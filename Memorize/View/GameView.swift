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
                withAnimation(.easeInOut){
                    self.viewModel.resetGame()
                }
            }) {
                HStack {
                    Image(systemName: "repeat")
                        .font(.title)
                    Text("Reset")
                        .fontWeight(.semibold)
                        .font(.title)
                }.foregroundColor(color)
            }
            
            Grid(viewModel.cards) {card in
                CardView(card : card)
                    .onTapGesture{
                        withAnimation(.linear(duration: 0.6)){
                            self.viewModel.choose(card:card)
                            
                        }
                }
                    
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
    @State private var animatedBonusRemainig:Double = 0
    
    var body : some View {
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    private func startAnimationTime(){
        animatedBonusRemainig = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)){
            animatedBonusRemainig = 0
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemainig*360-90), clockWise: true)
                        .padding(5)
                        .opacity(0.35)
                        .onAppear{
                            self.startAnimationTime()
                        }
                } else {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockWise: true)
                        .padding(5)
                        .opacity(0.35)
                }
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size) ))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false): .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.slide)
        }
    }
    
    // MARK: - Drawing Constant
    private  let fontScale: CGFloat = 0.7
    private  func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScale
    }
}

