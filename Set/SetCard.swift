//
//  SetCard.swift
//  Set
//
//  Created by Cormac McCarty on 5/22/18.
//  Copyright © 2018 Cormac McCarty. All rights reserved.
//

import Foundation
struct SetCard: Equatable {
    let shape: CardCharacteristic
    let color: CardCharacteristic
    let shading: CardCharacteristic
    let number: CardCharacteristic
    
    func matches(_ firstCard: SetCard, and secondCard: SetCard) -> Bool {
        return shape.matches(firstCard.shape, and: secondCard.shape) &&
            color.matches(firstCard.color, and: secondCard.color) &&
            shading.matches(firstCard.shading, and: secondCard.shading) &&
            number.matches(firstCard.number, and: secondCard.number)
    }
}
