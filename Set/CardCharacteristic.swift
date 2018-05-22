//
//  CardCharacteristic.swift
//  Set
//
//  Created by Cormac McCarty on 5/22/18.
//  Copyright © 2018 Cormac McCarty. All rights reserved.
//

import Foundation

enum CardCharacteristic: Int {
    case one = 1, two, three
    
    static let allValues: [CardCharacteristic] = [.one, .two, .three]
    
    func matches(_ firstCharacteristic: CardCharacteristic, and secondCharacteristic: CardCharacteristic) -> Bool {
        return (self == firstCharacteristic && self == secondCharacteristic) ||
            (self != firstCharacteristic && self != secondCharacteristic && firstCharacteristic != secondCharacteristic)
    }
}
