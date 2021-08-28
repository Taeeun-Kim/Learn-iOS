//
//  ViewController.swift
//  Concentration-UIKit
//
//  Created by Taeeun Kim on 25.08.21.
//

import UIKit

// UIViewController <- super class
class ViewController: UIViewController {
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCard(withEmoji: "👻", on: sender)
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        
    }
}

