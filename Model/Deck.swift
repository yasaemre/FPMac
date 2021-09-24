//
//  Deck.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//
import Foundation

struct Deck: Identifiable {
     var id = UUID()
     var deckName: String = ""
     var numberOfCardsInDeck: Int = 0
     var deckCreatedAt: String = ""
    
    func getTodayDate() -> String
    {
        let today = Date()
        let formatter3 = DateFormatter()
        formatter3.dateStyle = .short
        return formatter3.string(from: today)
        
    }
}
