//
//  ViewController.swift
//  Concentration
//
//  Created by Tanya Marych on 7/29/19.
//  Copyright © 2019 Tanya Marych. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    lazy var theme = Theme.getRandomTheme()
    var emoji = [Int:String]()

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var startGameButton: UIButton!
    
    @IBAction func startNewGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        restartGame()
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in card buttons");
        }
    }
    
    override func viewDidLoad() {
        updateViewWithTheme()
    }
    
    func updateViewWithTheme(){
        view.backgroundColor = theme.mainColor
        flipCountLabel.textColor = theme.faceDownColor
        scoreLabel.textColor = theme.faceDownColor
        startGameButton.setTitleColor(theme.startGameColor, for: UIControl.State.normal)
        for button in cardButtons {
            button.backgroundColor = theme.faceDownColor
        }
    }
    
    func restartGame() {
        theme = Theme.getRandomTheme()
        updateViewFromModel()
        updateViewWithTheme()
        emoji.removeAll()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = theme.faceUpColor
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0) : theme.faceDownColor
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func emoji(for card:Card) -> String {
        if emoji[card.identifier] == nil, theme.emoji.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(theme.emoji.count)))
            emoji[card.identifier] = theme.emoji.remove(at: randomIndex)
        }
       return emoji[card.identifier] ?? "?"
    }
}

