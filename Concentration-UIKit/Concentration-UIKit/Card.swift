//
//  Card.swift
//  Concentration-UIKit
//
//  Created by Taeeun Kim on 06.09.21.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    init(identifier: Int) {
        self.identifier = identifier
    }
}
