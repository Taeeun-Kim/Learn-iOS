//
//  ViewController.swift
//  Concentration-UIKit
//
//  Created by Taeeun Kim on 25.08.21.
//

import UIKit

// UIViewController <- super class
class ViewController: UIViewController {
    
    var flipCount: Int = 0 {
        didSet { // observer property
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("error")
        }
    }
    
//    @IBAction func touchSecondCard(_ sender: UIButton) {
//        flipCount += 1
//        flipCountLabel.text = "Flips: \(flipCount)"
//        flipCard(withEmoji: "🎃", on: sender)
//    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}

