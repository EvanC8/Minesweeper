//
//  ContentView.swift
//  Minesweeper
//
//  Created by Evan Cedeno on 11/21/24.
//

import SwiftUI

enum Page {
    case menu
    case game
}

struct ContentView: View {
    @State var gameMode: GameMode = .easy
    @State var page: Page = .menu
    
    var body: some View {
        if page == .menu {
            Menu(gameMode: $gameMode, page: $page)
        } else if page == .game {
            GameView(gameMode: $gameMode, page: $page)
        }
    }
}

//#Preview {
//    ContentView()
//}

extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}
