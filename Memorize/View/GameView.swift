//
//  GameView.swift
//  Memorize
//
//  Created by Hugo Santiago on 17/08/20.
//  Copyright © 2020 Hugo Santiago. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var color:Color
    var themeName:String
    var body: some View {
        Group {
            
            Button(action: {
                self.viewModel.resetGame()
            }) {
                HStack {
                    Image(systemName: "repeat")
                        .font(.title)
                    Text("Repeat")
                        .fontWeight(.semibold)
                        .font(.title)
                }.foregroundColor(color)
            }
            
            Grid(viewModel.cards) {card in
                CardView(card : card)
                    .onTapGesture{ self.viewModel.choose(card:card) }
                    .padding(5)
            }
            .padding()
            .foregroundColor(color)
            
            HStack{
                Text("Score")
                Text(String(viewModel.score))
            }
            .font(Font.title)
            .foregroundColor(color)
        }
        .navigationBarTitle(themeName)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    var body : some View {
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockWise: true)
                    .padding(5)
                    .opacity(0.35)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size) ))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
        
    }
    
    // MARK: - Drawing Constant
    private  let fontScale: CGFloat = 0.7
    private  func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScale
    }
}

