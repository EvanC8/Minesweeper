//
//  Menu.swift
//  Minesweeper
//
//  Created by Evan Cedeno on 11/23/24.
//

import SwiftUI

struct Menu: View {
    @Binding var gameMode: GameMode
    @Binding var page: Page
    
    let backgroundColor = Color(UIColor(red: 56/255, green: 116/255, blue: 203/255, alpha: 1))
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack {
                Text("Minesweeper")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, 50)
                HStack {
                    Text("GAME MODE")
                        .foregroundStyle(.white)
                        .font(.system(size: 40, weight: .bold))
                    Spacer()
                    HStack(spacing: 10) {
                        Text("EASY")
                            .foregroundStyle(gameMode == .easy ? backgroundColor : .white)
                            .font(.system(size: 30, weight: .bold))
                            .padding(10)
                            .background {
                                if gameMode == .easy {
                                    Capsule()
                                        .fill(.white)
                                }
                            }
                            .onTapGesture {
                                gameMode = .easy
                            }
                        Text("MEDIUM")
                            .foregroundStyle(gameMode == .medium ? backgroundColor : .white)
                            .font(.system(size: 30, weight: .bold))
                            .padding(10)
                            .background {
                                if gameMode == .medium {
                                    Capsule()
                                        .fill(.white)
                                }
                            }
                            .onTapGesture {
                                gameMode = .medium
                            }
                        Text("HARD")
                            .foregroundStyle(gameMode == .hard ? backgroundColor : .white)
                            .font(.system(size: 30, weight: .bold))
                            .padding(10)
                            .background {
                                if gameMode == .hard {
                                    Capsule()
                                        .fill(.white)
                                }
                            }
                            .onTapGesture {
                                gameMode = .hard
                            }
                    }
                }
                .padding(.horizontal, 40)
                    
                
                Spacer()
                
                Text("PLAY")
                    .foregroundStyle(backgroundColor)
                    .font(.system(size: 30, weight: .bold))
                    .padding(10)
                    .padding(.horizontal, 20)
                    .background {
                        Capsule()
                            .fill(.white)
                    }
                    .onTapGesture {
                        page = .game
                    }
            }
            .padding()
        }
    }
}
