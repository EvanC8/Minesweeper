//
//  CellView.swift
//  Minesweeper
//
//  Created by Evan Cedeno on 11/21/24.
//

import SwiftUI

struct CellView: View {
    @State var length: CGFloat
    
    @StateObject var cell: Cell
    var board: Board
    
    @State var animateMine = false
    @State var show = true
    
    var body: some View {
        let loc = cell.getLocation()
        ZStack {
            // Background
            Rectangle()
                .fill((loc.0 + loc.1) % 2 == 0 ? .gray1 : .gray2)
                .frame(width: length, height: length)
            
            if cell.isVisible() {
                if cell.isMine() {
                    // Mine
                    Circle()
                        .fill(animateMine ? .pink : .red)
                        .frame(width: length * 0.45, height: length * 0.45)
                        .glow(color: animateMine ? .pink : .red, radius: animateMine ? 5 : 0)
                        .scaleEffect(animateMine ? 1.1 : 1.0)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                animateMine = true
                            }
                        }
                }
                else if (!cell.isEmpty()) {
                    // Number
                    Text(String(cell.getValue()))
                        .foregroundStyle(cell.valueColor())
                        .font(.system(size: 50, weight: .black))
                        .minimumScaleFactor(0.5)
                        .padding(5)
                }
            }
            
            // Grass
            Rectangle()
                .fill((loc.0 + loc.1) % 2 == 0 ? .green1 : .green2)
                .frame(width: length, height: length)
                .opacity(show ? 1.0 : 0.0)
            
            if cell.isFlagged() {
                // Flag
                Image("flag")
                    .resizable()
                    .scaledToFit()
                    .padding(length * 0.1)
            }
            
        }
        .frame(width: length, height: length)
        .onLongPressGesture(minimumDuration: 0.2, perform: {
            board.longPress(cell)
        })
        .onTapGesture {
            board.tap(cell)
        }
        .onChange(of: cell.isVisible()) { _, _ in
            withAnimation(.easeOut(duration: 0.2).delay(cell.getDelay() * 0.8)) {
                show = false
            }

        }
            
    }
}
//
////#Preview {
////    CellView()
////}
