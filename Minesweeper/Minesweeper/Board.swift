//
//  Board.swift
//  Minesweeper
//
//  Created by Evan Cedeno on 11/21/24.
//

import SwiftUI

enum GameMode {
    case easy
    case medium
    case hard
}

class Board: ObservableObject {
    
    @Published private var gameMode = GameMode.easy
    
    @Published private var rows: Int = 0
    @Published private var columns: Int = 0
    @Published private var cells: [[Cell]] = []
    @Published private var mines: Int = 0
    
    @Published private var radius: Int = 0
    
    @Published private var firstClick: Bool = true
    
    @Published private var flags: Int = 0
    @Published private var time: Int = 0
    
    @Published private var gameOver = false
    
    //MARK: Intialize Game Board
    init(mode: GameMode) {
        setupBoard(mode: mode)
    }
    
    public func setupBoard(mode: GameMode) {
        if (mode == .easy) {
            self.rows = 8
            self.columns = 10
            self.mines = 10
            self.radius = 1
        }
        else if (mode == .medium) {
            self.rows = 14
            self.columns = 18
            self.mines = 40
            self.radius = 1
        }
        else {
            self.rows = 20
            self.columns = 24
            self.mines = 99
            self.radius = 2
        }
        
        self.cells.removeAll()
        self.cells = [[Cell]](repeating: [Cell](repeating: Cell(0, 0), count: columns), count: rows)
        self.cells = (0..<rows).map { i in (0..<columns).map { j in Cell(i, j) } }
        
        firstClick = true
        flags = mines
        time = 0
        gameOver = false
        
        gameMode = mode
    }
    
    public func resetBoard(mode: GameMode) {
        setupBoard(mode: mode)
    }
    
    //MARK: Print board array
    public func printBoard() {
        for row in cells {
            for column in row {
                print(column.getValue(), terminator: "\t")
            }
            print("\n")
        }
    }
    
    //MARK: Generate mines
    public func placeMines(origin: (Int, Int)) {
        // Generate each mine
        for _ in 0..<mines {
            let loc = findEmptySpot(excluding: origin, radius: radius)
            placeMine(loc.0, loc.1)
        }
    }
    
    private func findEmptySpot(excluding: (Int, Int), radius: Int) -> (Int, Int) {
        var cell: Cell? = nil
        var row: Int = 0
        var column: Int = 0
        var illegalSpot = false
        
        // Find empty cell
        repeat {
            row = Int.random(in: 0..<rows)
            column = Int.random(in: 0..<columns)
            cell = getCell(row, column)
            illegalSpot = (row >= excluding.0 - radius && row <= excluding.0 + radius && column >= excluding.1 - radius && column <= excluding.1 + radius)
        } while (cell!.isMine() || illegalSpot)
        
        return (row, column)
    }
    
    private func placeMine(_ row: Int, _ column: Int) {
        let cell = getCell(row, column)
        
        // Place mine
        cell.setMine()
        
        // Increment value of adjacent cells
        incrementAdjacentCells(row, column)
    }
    
    public func getCell(_ row: Int, _ column: Int) -> Cell {
        return cells[row][column]
    }
    
//    private func locateCell(_ cell: Cell) -> (Int, Int)? {
//        for (row, rowCells) in cells.enumerated() {
//            for (column, columnCell) in rowCells.enumerated() {
//                if columnCell === cell {
//                    return (row, column)
//                }
//            }
//        }
//        return nil
//    }
    
    private func incrementAdjacentCells(_ row: Int, _ column: Int) {
        // Iterate through adjacent cells
        for i in stride(from: row-1, through: row+1, by: 1) {
            for j in stride(from: column-1, through: column+1, by: 1) {
                // Check if i, j are in bounds of board
                if (inBounds(i, j)) {
                    let cell = getCell(i, j)
                    // Exclude mine cells
                    if !cell.isMine() {
                        // Increment value
                        cell.incrementValue()
                    }
                }
            }
        }
    }
    
    //MARK: Cell Press Events
    
    public func longPress(_ cell: Cell) {
        if gameOver { return }
        
        print("Long pressed at row: \(cell.getLocation().0), column: \(cell.getLocation().1)")
        if (firstClick) { return }
        
        if !cell.isVisible() {
            if cell.isFlagged() {
                print("Flag removed")
                cell.setFlag(false)
                flags += 1
            }
            else {
                if (flags <= 0) { return }
                print("Flagged")
                cell.setFlag(true)
                flags -= 1
            }
        }
    }
    
    public func tap(_ cell: Cell) {
        if gameOver { return }
        
        print("Tapped at row: \(cell.getLocation().0), column: \(cell.getLocation().1)")
        
        if (firstClick) {
            firstClick.toggle()
            let loc = cell.getLocation()
            print("Opening move")
            handleFirstClick(loc.0, loc.1)
            return
        }
        
        showCell(cell)
        if (cell.isEmpty()) {
            let loc = cell.getLocation()
            revealAdjacentEmptySpaces(loc.0, loc.1, delay: 0)
        }
    }
    
    private func showCell(_ cell: Cell) {
        print("Shown")
        cell.setVisible()
        cell.setFlag(false)
        
        if cell.isMine() {
            self.gameOver = true
        }
        
        if (isWinner()) {
            self.gameOver = true
        }
    }
    
    private func isWinner() -> Bool {
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                let cell = getCell(row, column)
                if !cell.isVisible() && !cell.isMine() {
                    return false
                }
            }
        }
        return true
    }
    
    public func handleFirstClick(_ row: Int, _ column: Int) {
        // Place mines around click origin
        placeMines(origin: (row, column))
        
        // Reveal adjacent empty spaces recursively
        let cell = getCell(row, column)
        showCell(cell)
        revealAdjacentEmptySpaces(row, column, delay: 0)
        print("recursion finished")
    }
    
    private func revealAdjacentEmptySpaces(_ row: Int, _ column: Int, delay: CGFloat) {
//        let sections = [(0, 1), (1, 0), (0, -1), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]
        let sections = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        
        var currentDelay = delay
        
        for section in sections {
            let loc = (row + section.0, column + section.1)
            
            if (!inBounds(loc.0, loc.1)) { continue }
            
            let cell = getCell(loc.0, loc.1)
            
            if (cell.isVisible()) { continue }
            if (cell.isMine()) { continue }
            
            cell.setDelay(currentDelay)
            showCell(cell)
            
            currentDelay += 0.01
            
            if (cell.isEmpty()) {
                revealAdjacentEmptySpaces(loc.0, loc.1, delay: currentDelay)
            }
        }
        
    }
    
    private func inBounds(_ row: Int, _ column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    //MARK: Getter methods
    public func getCells() -> [[Cell]] {
        return cells
    }
    
    public func getRows() -> Int {
        return rows
    }
    
    public func getColumns() -> Int {
        return columns
    }
    
    public func getGameMode() -> GameMode {
        return gameMode
    }
    
    public func getTime() -> Int {
        return time
    }
    
    public func getFlags() -> Int {
        return flags
    }
    
    public func isGameOver() -> Bool {
        return gameOver
    }
    
    public func isFirstClick() -> Bool {
        return firstClick
    }
    
    public func incrememntTime() {
        if isGameOver() { return }
        if isFirstClick() { return }
        time += 1
    }
    
}
