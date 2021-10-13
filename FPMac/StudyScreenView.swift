//
//  StudyScreenView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//
//


import SwiftUI
import Foundation

struct StudyScreenView: View {
    // MARK: - Drawing Constant
    @StateObject var deckCore:DeckCore
    @State var card:Card

    @Binding var indexCard:Int
    @State var flipped = false
    @State var flip = false

    @State var correctAnswer = 0
    @State var resetBg = false
    @State var correctRate = 0.0
    @State var falseAnswer = 0
    @State var correctA = 0.0
    @State var prevCorrectA  = 0.0

    var body: some View {
        
        ZStack(alignment: .top){
            ForEach(deckCore.cardsArray.reversed()) { cardCore in
                CardView(cardCore: cardCore, card: card, flipped: $flipped, flip: $flip, deckCore: deckCore, indexCard: $indexCard, correctAnswer: $correctAnswer,  falseAnswer: $falseAnswer, resetBg: $resetBg, correctA: $correctA)
                    .onAppear {
                        indexCard = deckCore.cardsArray.count-1
            
                    }
            }
        }
        .onDisappear{
            if prevCorrectA != correctA {
            deckCore.correctRate = (correctA / Double(deckCore.cardsArray.count)) * 100.0
            }
            prevCorrectA = correctA
        }
        
       
        .zIndex(1.0)
    }
}
