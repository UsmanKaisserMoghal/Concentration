//
//  Card.swift
//  Concentration
//
//  Created by iMAC2 on 08/11/2018.
//  Copyright © 2018 FAST. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hasValue: Int {return identifier}
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    var isSeen = false
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
