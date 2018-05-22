//
//  SetGame.swift
//  Set
//
//  Created by Cormac McCarty on 5/22/18.
//  Copyright © 2018 Cormac McCarty. All rights reserved.
//

import Foundation

struct SetGame {
    private let initialDeal = 12
    private let maxAllowableCards = 24
    let maxSelection = 3
    private var selectedCards: [SetCard] {
        return cardsInPlay.filter { $0.isSelected }.map { $0.card! }
    }
    private var maxNumberOfCards = 12
    private var deck = [SetCard]()
    private var matchedCards = [SetCard]()
    private(set) var cardsInPlay: [(card: SetCard?, isSelected: Bool)]
    private(set) var score = 0
    
    var isSelectionMatched: Bool {
        return selectedCards.count == maxSelection ? selectedCards[0].matches(selectedCards[1], and: selectedCards[2]) : false
    }
    
    var canDealCards: Bool {
        return maxNumberOfCards < maxAllowableCards && !deck.isEmpty
    }
    
    var selectedCount: Int {
        return selectedCards.count
    }
    
    private mutating func scoreRound() {
        if isSelectionMatched {
            score += 3
        } else {
            score -= 5
        }
    }
    
    private mutating func resetBoard() {
        if isSelectionMatched {
            let draw = drawThreeCards()
            for newCard in draw {
                // Replace matched cards from drawn cards
                cardsInPlay[cardsInPlay.index(where: { $0.isSelected} )!] = (newCard, false)
            }
            while let index = cardsInPlay.index(where: { $0.isSelected} ) {
                // Clear cards that can't be replaced from empty deck
                cardsInPlay[index] = (nil, false)
            }
        } else {
            // Clear selections
            cardsInPlay = cardsInPlay.map { ($0.card, false) }
        }
    }
    
    mutating func selectCard(withIndex index: Int) {
        let selection = cardsInPlay[index]
        if selection.card != nil {
            if selectedCards.count == maxSelection {
                resetBoard()
            }
            cardsInPlay[index].isSelected = !selection.isSelected
            if selectedCards.count == maxSelection {
                scoreRound()
            }
        }
    }
    
    private mutating func drawThreeCards() -> [SetCard] {
        return deck.takeFirst(3)
    }
    
    mutating func dealThreeCards() {
        assert(canDealCards, "SetGame.dealThreeCards: Tried to deal cards when already at max")
        let cards = drawThreeCards()
        for card in cards {
            cardsInPlay[maxNumberOfCards] = (card, false)
            maxNumberOfCards += 1
        }
    }
    
    init() {
        deck = [SetCard]()
        for shape in CardCharacteristic.allValues {
            for color in CardCharacteristic.allValues {
                for shading in CardCharacteristic.allValues {
                    for number in CardCharacteristic.allValues {
                        deck.append(SetCard(shape: shape, color: color, shading: shading, number: number))
                    }
                }
            }
        }
        deck.shuffle()
        cardsInPlay = deck.takeFirst(initialDeal).map { ($0, false) }
        while cardsInPlay.count < maxAllowableCards {
            cardsInPlay.append((nil, false))
        }
        matchedCards = [SetCard]()
    }
}

