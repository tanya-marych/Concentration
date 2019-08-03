//
//  Theme.swift
//  Concentration
//
//  Created by Tanya Marych on 8/3/19.
//  Copyright © 2019 Tanya Marych. All rights reserved.
//

import Foundation
import UIKit

let hallowenEmoji = ["🎃", "👻", "😈", "☠️", "💀", "👁", "🧟‍♂️", "🕸", "🕷", "🍭"];
let animalsEmoji = ["🐶", "🐸", "🐥", "🐢", "🐈", "🐇", "🦊"];

struct Theme {
    var name: String
    var emoji: [String]
    var faceDownColor: UIColor
    var faceUpColor: UIColor
    var startGameColor: UIColor
    var mainColor: UIColor
    
    static var themes: [Theme] = [
        Theme(name: "hallowen",  emoji: hallowenEmoji, faceDownColor: UIColor.orange, faceUpColor: UIColor.white, startGameColor: UIColor.white, mainColor: UIColor.black),
        Theme(name: "animals",  emoji: animalsEmoji, faceDownColor: UIColor.orange, faceUpColor: UIColor.white, startGameColor: UIColor.white, mainColor: UIColor.brown)
    ];
    
    static func getRandomTheme() -> Theme {
        let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
        
        return themes[randomIndex]
    }
    
    init(name: String, emoji: [String], faceDownColor: UIColor, faceUpColor: UIColor, startGameColor: UIColor, mainColor: UIColor) {
        self.name = name
        self.emoji = emoji
        self.faceDownColor = faceDownColor
        self.faceUpColor = faceUpColor
        self.startGameColor = startGameColor
        self.mainColor = mainColor
    }
}
