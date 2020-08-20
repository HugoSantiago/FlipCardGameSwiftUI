//
//  MemoryGame.swift
//  Memorize
//
//  Created by Hugo Santiago on 18/08/20.
//  Copyright © 2020 Hugo Santiago. All rights reserved.
// 

import Foundation
import SwiftUI
struct MemoryGame <CardContent> where CardContent: Equatable {
    var cards : Array<Card>
    var score: Int
    
    var indexOfTheOnlyFaceUpCard: Int? {
        get {
            var faceUpCardsIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp{
                    faceUpCardsIndices.append(index)
                }
            }
            if faceUpCardsIndices.count == 1{
                return faceUpCardsIndices[0]
            } else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairs{
            
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
            cards.shuffle()
        }
        score = 0
    }
    
    mutating func resetGame(){
        for index in 0..<cards.count {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        score = 0
    }
    
    mutating func choose (card:Card){
        
        if let chosenCard: Int = cards.firstIndex(matching: card), !cards[chosenCard].isFaceUp, !cards[chosenCard].isMatched {
            if let potencialMatchedIndex = indexOfTheOnlyFaceUpCard {
                if cards[chosenCard].content == cards[potencialMatchedIndex].content {
                    cards[chosenCard].isMatched = true
                    cards[potencialMatchedIndex].isMatched = true
                    score += 3
                }
                self.cards[chosenCard].isFaceUp = true
                score -= 1
            } else {
                indexOfTheOnlyFaceUpCard = chosenCard
            }
        }
        print(score)
    }
    
    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
    }
}
