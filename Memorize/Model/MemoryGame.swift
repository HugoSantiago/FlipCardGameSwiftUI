//
//  MemoryGame.swift
//  Memorize
//
//  Created by Hugo Santiago on 18/08/20.
//  Copyright © 2020 Hugo Santiago. All rights reserved.
//

import Foundation

struct MemoryGame <CardContent> {
    var cards : Array<Card>
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairs{
            
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
            cards.shuffle()
        }
    }
    
    func choose (card:Card){
        print("Card chosen: \(card)")
    }
    struct Card: Identifiable {
        
        var id: Int
        
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
