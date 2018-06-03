//
//  ViewController.swift
//  Set
//
//  Created by Cormac McCarty on 5/22/18.
//  Copyright © 2018 Cormac McCarty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = SetGame() {
        didSet {
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func selectCard(_ sender: UIButton) {
        game.selectCard(withIndex: cardButtons.index(of: sender)!)
    }
    
    @IBAction func dealThreeCards() {
        game.dealThreeCards()
    }
    
    @IBAction func newGame() {
        game = SetGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        dealButton.isEnabled = game.canDealCards
        var selectionColor: UIColor
        if game.selectedCount < game.maxSelection {
            selectionColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        } else {
            selectionColor = game.isSelectionMatched ? #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        for index in cardButtons.indices {
            if index < game.cardsInPlay.count {
                let card = game.cardsInPlay[index].card
                renderCardContent(for: card, on: cardButtons[index])
                cardButtons[index].layer.cornerRadius = 8.0
                if game.cardsInPlay[index].isSelected {
                    cardButtons[index].layer.borderWidth = 3.0
                    cardButtons[index].layer.borderColor = selectionColor.cgColor
                } else {
                    cardButtons[index].layer.borderWidth = 0.0
                    cardButtons[index].layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0).cgColor
                }
            } else {
                // No card
                cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                cardButtons[index].setAttributedTitle(NSAttributedString(), for: .normal)
                cardButtons[index].setTitle("", for: .normal)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func renderCardContent(for card: SetCard, on button: UIButton) {
        var foregroundColor: UIColor
        switch card.color {
        case .green:
            foregroundColor = UIColor.green
        case .red:
            foregroundColor = UIColor.red
        case .purple:
            foregroundColor = UIColor.purple
        }
        var strokeWidth = 0.0
        switch card.fill {
        case .stripes:
            foregroundColor = foregroundColor.withAlphaComponent(0.25)
        case .solid:
            foregroundColor = foregroundColor.withAlphaComponent(1.0)
        case .outline:
            strokeWidth = 5.0
        }
        var symbol: String
        switch card.symbol {
        case .diamond:
            symbol = "▲"
        case .oval:
            symbol = "●"
        case .squiggle:
            symbol = "■"
        }
        var title: String = String()
        for _ in 0..<card.number.rawValue {
            title.append(symbol + "\n")
        }
        let attributes: [NSAttributedStringKey : Any] = [
            .strokeColor : foregroundColor,
            .strokeWidth : strokeWidth
        ]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        button.setAttributedTitle(attributedString, for: .normal)
        if let label = button.titleLabel {
            label.numberOfLines = 3
            label.textColor = foregroundColor
        }
        button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }
}

