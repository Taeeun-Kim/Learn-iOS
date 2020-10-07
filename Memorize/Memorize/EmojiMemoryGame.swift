//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Taeeun Kim on 25.08.20.
//  Copyright © 2020 Taeeun Kim. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame{
    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2)
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    // MARK: - intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}
