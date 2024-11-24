//
//  GameView.swift
//  Minesweeper
//
//  Created by Evan Cedeno on 11/23/24.
//

import SwiftUI

struct GameView: View {
    
    @Binding var gameMode: GameMode
    @Binding var page: Page
    
    @StateObject var board: Board = Board(mode: .easy)
    @State var timer: Timer?
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                HStack(spacing: 30) {
                    HStack(spacing:10) {
                        let flags = board.getFlags()
                        
                        Image("flag")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        Text(String(format: "%02d", flags))
                            .foregroundStyle(.black)
                            .font(.system(size: 50, weight: .bold))
                            .monospacedDigit()
                        
                    }
                    HStack(spacing: 10) {
                        let time = board.getTime()
                        
                        Image("stopwatch")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        Text(String(format: "%03d", time))
                            .foregroundStyle(.black)
                            .font(.system(size: 50, weight: .bold))
                            .monospacedDigit()
                            .onChange(of: board.isFirstClick()) { oldValue, newValue in
                                if !newValue {
                                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                                        board.incrememntTime()
                                    })
                                }
                            }
                            .onChange(of: board.isGameOver()) { oldValue, newValue in
                                if newValue {
                                    timer?.invalidate()
                                }
                            }
                        
                    }
                    Spacer()
                    
                    Image(systemName: "speaker.wave.2")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.black)
                    Image(systemName: "xmark")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.black)
                        .onTapGesture {
                            page = .menu
                        }
                }
                .padding(.horizontal, 30)
                
                BoardView(board: board)
                    .padding(20)
            }
            Spacer()
        }
        .onAppear {
            board.resetBoard(mode: gameMode)
        }
    }
}

