//
//  Concentration.swift
//  Concentration
//
//  Created by iMAC2 on 08/11/2018.
//  Copyright © 2018 FAST. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private(set) var flipCount: Int
    private(set) var score: Int
    
    mutating func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard: (at: \(index)): chosen index not in range")
        
        if !cards[index].isMatched && !cards[index].isFaceUp {
            flipCount += 1
        }
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
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
    
    mutating func startNewGame() {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
            cards[index].isSeen = false
        }
        
        flipCount = 0
        score = 0
        
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
