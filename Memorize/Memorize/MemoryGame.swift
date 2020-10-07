//
//  MemoryGame.swift
//  Memorize
//
//  Created by Taeeun Kim on 25.08.20.
//  Copyright © 2020 Taeeun Kim. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent>{
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    init(numberOfPairsOfCards: Int){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            cards.append(Card())
            cards.append(Card())
        }
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
