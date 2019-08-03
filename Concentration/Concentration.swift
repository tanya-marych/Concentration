//
//  Concentration.swift
//  Concentration
//
//  Created by Tanya Marych on 7/30/19.
//  Copyright © 2019 Tanya Marych. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFacedUpCard: Int?
    var flipCount: Int = 0
    var score: Int = 0
    var alreadyChoosenBeforeCards = [Int]()
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFacedUpCard, matchIndex != index {
                let areCardsMatched = cards[matchIndex].identifier == cards[index].identifier
                if areCardsMatched {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                updateScore(isMatched: areCardsMatched, card1Index: index, card2Index: matchIndex)

                cards[index].isFaceUp = true
                indexOfOneAndOnlyFacedUpCard = nil
            } else {
                // either no cards or both cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFacedUpCard = index
            }
        }
    }
    
    func updateScore(isMatched: Bool, card1Index: Int, card2Index: Int) {
        if isMatched {
            score += 2
        } else {
            let isCard1ChoosenBefore = alreadyChoosenBeforeCards.contains(card1Index)
            let isCard2ChoosenBefore = alreadyChoosenBeforeCards.contains(card2Index)
            
            if isCard1ChoosenBefore, isCard2ChoosenBefore {
                score -= 2
            }else if isCard1ChoosenBefore || isCard2ChoosenBefore {
                score -= 1
            }
        }
        
        updateChoosenCards(indexes: [card1Index, card2Index])
    }
    
    func updateChoosenCards(indexes: [Int]) {
        for index in indexes {
            if !alreadyChoosenBeforeCards.contains(index) {
                alreadyChoosenBeforeCards.append(index)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()

        indexOfOneAndOnlyFacedUpCard = nil
        flipCount = 0
        score = 0
        alreadyChoosenBeforeCards = []
    }
}
