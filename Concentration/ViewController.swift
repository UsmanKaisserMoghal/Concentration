//
//  ViewController.swift
//  Concentration
//
//  Created by iMAC2 on 08/11/2018.
//  Copyright © 2018 FAST. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func newGame(_ sender: UIButton) {
        game.startNewGame()
        updateViewFromModel()
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: noOfPairs)
    
    var noOfPairs: Int {
        return (cardButtons.count + 1)/2
    }
    
    var flips: Int {
        return self.game.flipCount
    }
    
    var score: Int {
        return self.game.score
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print ("Error")
        }
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5746685863, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5746685863, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(flips)"
        scoreLabel.text = "Score: \(score)"
    }
    
    private var emojiChoices = "🎃👻🦇😱😈🍎🙀👺👹"
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card] == nil ,emojiChoices.count > 0 {
            let randomStringindex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringindex))
        }
        return emoji[card] ?? "?"
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
