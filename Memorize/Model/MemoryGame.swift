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
    //Private (set) = ReadOnly
    private(set) var cards : Array<Card>
    private(set) var score: Int
    
    private var indexOfTheOnlyFaceUpCard: Int? {
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
        cards.shuffle()
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
    }
    
    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool = false { didSet { isFaceUp ? startUsinBonusTime() : stopUsingBonusTIme() } }
        var isMatched: Bool = false { didSet { stopUsingBonusTIme() } }
        var content: CardContent
        
        var bonusTimeLimit : TimeInterval = 6
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate : Date?
        var pastFaceUpTime : TimeInterval = 0
        
        var bonusTimeRemaining : TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining : Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining : 0
        }
        
        var hasEarnedBonus : Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime : Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsinBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        private mutating func stopUsingBonusTIme(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
