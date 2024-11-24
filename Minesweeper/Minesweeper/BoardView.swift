//
//  BoardView.swift
//  Minesweeper
//
//  Created by Evan Cedeno on 11/21/24.
//

import SwiftUI

struct BoardView: View {
    
    @StateObject var board: Board
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        var cellLength = (screenWidth - 40) / CGFloat(board.getColumns())

        let cells = board.getCells()
        
//        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
//            ForEach(0..<rows) { row in
//                HStack(spacing: 0) {
//                    ForEach(0..<columns) { column in
//                        CellView(length: cellLength, cell: board.getCell(row, column), board: board)
//                    }
//                }
//            }
//        }
        VStack(spacing: 0) {
            ForEach(cells.indices, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(cells[row], id: \.id) { columnCell in
                        CellView(length: cellLength, cell: columnCell, board: board)
                    }
                }
            }
        }
    }
}

//#Preview {
//    BoardView()
//}
