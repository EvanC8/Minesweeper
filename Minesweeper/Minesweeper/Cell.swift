//
//  Cell.swift
//  Minesweeper
//
//  Created by Evan Cedeno on 11/21/24.
//

import Foundation
import SwiftUI


class Cell: ObservableObject, Identifiable {
    public var id: UUID = UUID()
    @Published private var value: Int
    @Published private var flag: Bool
    @Published private var visible: Bool
    @Published private var location: (Int, Int)
    @Published private var delay: CGFloat
    
    init(_ row: Int, _ column: Int) {
        self.value = 0
        self.flag = false
        self.visible = false
        self.location = (row, column)
        self.delay = 0.0
    }
    
    public func isMine() -> Bool {
        return value == -1
    }
    
    public func isEmpty() -> Bool {
        return value == 0
    }
    
    public func isFlagged() -> Bool {
        return self.flag
    }
    
    public func isVisible() -> Bool {
        return self.visible
    }
    
    public func getValue() -> Int {
        return value
    }
    
    public func getLocation() -> (Int, Int) {
        return location
    }
    
    public func getDelay() -> CGFloat {
        return delay
    }
    
    public func setFlag(_ isFlag: Bool) {
        self.flag = isFlag
    }
    
    public func setMine() {
        self.value = -1
    }
    
    public func setVisible() {
        print("Cell: showing cell at row: \(location.0), column: \(location.1)")
        self.visible = true
    }
    
    public func setDelay(_ delay: CGFloat) {
        self.delay = delay
    }
    
    public func incrementValue() {
        if isMine() { return }
        self.value += 1
    }
    
    public func valueColor() -> Color {
        switch value {
        case 0: return .clear
        case 1: return Color(UIColor(red: 56/255, green: 116/255, blue: 203/255, alpha: 1))
        case 2: return Color(UIColor(red: 80/255, green: 140/255, blue: 70/255, alpha: 1))
        case 3: return Color(UIColor(red: 194/255, green: 63/255, blue: 56/255, alpha: 1))
        case 4: return Color(UIColor(red: 113/255, green: 39/255, blue: 156/255, alpha: 1))
        case 5: return Color(UIColor(red: 240/255, green: 149/255, blue: 54/255, alpha: 1))
        case 6: return .purple
        case 7: return .brown
        case 8: return .black
        default: return .clear
        }
    }
    
}
