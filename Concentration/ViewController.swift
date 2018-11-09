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
        game.flipCount = 0
        game.score = 0
        updateViewFromModel()
    }
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    var flips: Int {
        return self.game.flipCount
    }
    
    var score: Int {
        return self.game.score
    }
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print ("Error")
        }
    }
    
    func updateViewFromModel(){
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
    
    var emojiChoices = ["🎃", "👻", "🦇", "😱", "😈", "🍎", "🙀", "👺", "👹"]
    
    var emoji = [Int : String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil ,emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

}
