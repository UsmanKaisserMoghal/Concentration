//
//  Concentration.swift
//  Concentration
//
//  Created by iMAC2 on 08/11/2018.
//  Copyright © 2018 FAST. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp == true {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private(set) var flipCount: Int
    private(set) var score: Int
    
    func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard: (at: \(index)): chosen index not in range")
        
        if !cards[index].isMatched && !cards[index].isFaceUp {
            flipCount += 1
        }
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].isSeen == true {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                cards[index].isSeen = true
            } else {
                cards[index].isSeen = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func startNewGame() {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
            cards[index].isSeen = false
        }
        
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int){
        
        assert(numberOfPairsOfCards > 0, "Concentration.init: (at: \(numberOfPairsOfCards)): must have atleast 1 pair of cards")
        
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        flipCount = 0
        score = 0
        
        cards.shuffle();
    }
}
