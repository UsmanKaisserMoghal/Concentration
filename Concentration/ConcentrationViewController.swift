//
//  ViewController.swift
//  Concentration
//
//  Created by iMAC2 on 08/11/2018.
//  Copyright © 2018 FAST. All rights reserved.
//

import UIKit

class ConcentrationViewController: VCLLoggingViewController {
    
    override var vclLoggingName: String {
        return "Game"
    }
    
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
    
    private let attributes: [NSAttributedString.Key: Any] = [
        .strokeWidth: 5.0,
        .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    ]
    
    private func updateFlipCountLabel() {
        let flipsAttributeString = NSAttributedString(string: "Flips:\(flips)", attributes: attributes)
        
        flipCountLabel.attributedText = flipsAttributeString
    }
    
    private func updateScoreLabel() {
        let scoreAttributeString = NSAttributedString(string: "Score:\(score)", attributes: attributes)
        
        scoreLabel.attributedText = scoreAttributeString
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print ("Error")
        }
    }
    
    private func updateViewFromModel(){
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5746685863, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
            updateFlipCountLabel()
            updateScoreLabel()
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
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
