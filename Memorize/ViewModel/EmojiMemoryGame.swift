//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Hugo Santiago on 18/08/20.
//  Copyright © 2020 Hugo Santiago. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>
    
    init(emojis:[String]){
        
        let randomInt = Int.random(in: 4..<8)
        model = MemoryGame<String>(numberOfPairs: randomInt) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func resetGame(){
        model.resetGame()
    }
}
