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
    let maxSelection = 3
    private var selectedCards: [SetCard] {
        return cardsInPlay.filter { $0.isSelected }.map { $0.card }
    }
    private var maxNumberOfCards = 12
    private var deck = [SetCard]()
    private(set) var cardsInPlay: [(card: SetCard, isSelected: Bool)]
    private(set) var score = 0
    
    var isSelectionMatched: Bool {
        return selectedCards.count == maxSelection ? selectedCards[0].matches(selectedCards[1], and: selectedCards[2]) : false
    }
    
    var canDealCards: Bool {
        return !deck.isEmpty
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
            cardsInPlay = cardsInPlay.filter { !$0.isSelected }
            cardsInPlay.append(contentsOf: drawThreeCards().map { (card: $0, isSelected: false) })
        } else {
            // Clear selections
            cardsInPlay = cardsInPlay.map { ($0.card, false) }
        }
    }
    
    mutating func selectCard(withIndex index: Int) {
        let selection = cardsInPlay[index]
        if selectedCards.count == maxSelection {
            resetBoard()
        }
        cardsInPlay[index].isSelected = !selection.isSelected
        if selectedCards.count == maxSelection {
            scoreRound()
        }
    }
    
    private mutating func drawThreeCards() -> [SetCard] {
        return deck.takeFirst(3)
    }
    
    mutating func dealThreeCards() {
        assert(canDealCards, "SetGame.dealThreeCards: Tried to deal cards when already at max")
        let cards = drawThreeCards()
        for card in cards {
            cardsInPlay.append((card, false))
            maxNumberOfCards += 1
        }
    }
    
    init() {
        deck = [SetCard]()
        for symbol in SetCard.SetSymbol.all {
            for color in SetCard.SetSymbolColor.all {
                for fill in SetCard.SetSymbolFill.all {
                    for count in SetCard.SetSymbolCount.all {
                        deck.append(SetCard(symbol: symbol, color: color, fill: fill, number: count))
                    }
                }
            }
        }
        deck.shuffle()
        cardsInPlay = deck.takeFirst(initialDeal).map { ($0, false) }
    }
}

