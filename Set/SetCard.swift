//
//  SetCard.swift
//  Set
//
//  Created by Cormac McCarty on 5/22/18.
//  Copyright © 2018 Cormac McCarty. All rights reserved.
//

import Foundation
struct SetCard: Equatable {
    let symbol: SetSymbol
    let color: SetSymbolColor
    let fill: SetSymbolFill
    let number: SetSymbolCount
    
    func matches(_ firstCard: SetCard, and secondCard: SetCard) -> Bool {
        return symbol.matches(firstCard.symbol, and: secondCard.symbol) &&
            color.matches(firstCard.color, and: secondCard.color) &&
            fill.matches(firstCard.fill, and: secondCard.fill) &&
            number.matches(firstCard.number, and: secondCard.number)
    }
    
    enum SetSymbol: SetCharacteristic {
        case squiggle, diamond, oval
        
        static var all = [SetSymbol.squiggle, .diamond, .oval]
    }
    
    enum SetSymbolFill: SetCharacteristic {
        case solid, stripes, outline
        
        static var all = [SetSymbolFill.solid, .stripes, .outline]
    }
    
    enum SetSymbolColor: SetCharacteristic {
        case green, red, purple
        
        static var all = [SetSymbolColor.green, .red, .purple]
    }
    
    enum SetSymbolCount: Int, SetCharacteristic {
        case one = 1, two, three
        
        static var all = [SetSymbolCount.one, .two, .three]
    }
}

extension SetCharacteristic {
    func matches(_ firstCharacteristic: Self, and secondCharacteristic: Self) -> Bool {
        return (self == firstCharacteristic && self == secondCharacteristic) ||
            (self != firstCharacteristic && self != secondCharacteristic && firstCharacteristic != secondCharacteristic)
    }
}

protocol SetCharacteristic: Equatable {
    func matches(_ firstCharacteristic: Self, and secondCharacteristic: Self) -> Bool
}
