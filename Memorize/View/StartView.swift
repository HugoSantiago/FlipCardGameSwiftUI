//
//  StartView.swift
//  Memorize
//
//  Created by Hugo Santiago on 20/08/20.
//  Copyright © 2020 Hugo Santiago. All rights reserved.
//

import SwiftUI

struct StartView: View {
    var games: [GameClass]
    var body: some View {
        NavigationView{
            List{
                ForEach(games){game in
                    NavigationLink(destination: GameView(viewModel: EmojiMemoryGame(emojis: game.emojis), color: game.color, themeName: game.name)){
                        OptionView(name: game.name, emojis: game.emojis, color: game.color)
                    }
                }
            }
            .navigationBarTitle("Flip Card Game")
        }
    }
}

struct OptionView : View{
    
    var name:String
    var emojis:[String]
    var color:Color
    
    var body: some View {
        VStack{
            Text(name)
                .font(Font.title)
                .foregroundColor(color)
            Text(emojis.joined(separator: ""))
        }
    }
}
