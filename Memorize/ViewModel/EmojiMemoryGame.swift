//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Hugo Santiago on 18/08/20.
//  Copyright © 2020 Hugo Santiago. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻","🎃", "🕷", "🙀","💀", "👽"]
        let randomInt = Int.random(in: 1..<6)
        print("Numero ale pares \(randomInt)")
        return MemoryGame<String>(numberOfPairs: randomInt) { pairIndex in
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
}
