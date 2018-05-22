//
//  Extensions.swift
//  Set
//
//  Created by Cormac McCarty on 5/22/18.
//  Copyright © 2018 Cormac McCarty. All rights reserved.
//

import Foundation

extension Array {
    mutating func takeFirst(_ maxNumber: Int) -> Array  {
        let takenElements = Array(self.prefix(maxNumber))
        let rangeToRemove = maxNumber < self.count ? 0..<maxNumber : 0..<self.count
        self.removeSubrange(rangeToRemove)
        return takenElements
    }
}

// Extensions borrowed from Apple to implement Fisher Yates shuffling
extension Collection {
    func shuffled() -> [Iterator.Element] {
        var array = Array(self)
        array.shuffle()
        return array
    }
}

extension MutableCollection {
    mutating func shuffle() {
        var i = startIndex
        var n = count
        
        while n > 1 {
            let j = index(i, offsetBy: random(n))
            swapAt(i, j)
            formIndex(after: &i)
            n -= 1
        }
    }
}

public func random<T: BinaryInteger> (_ n: T) -> T {
    return numericCast( arc4random_uniform( numericCast(n) ) )
}
