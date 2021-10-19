//
//  DeckListRow.swift
//  FPMac
//
//  Created by Emre Yasa on 10/1/21.
//

import SwiftUI

struct DeckListRow: View {
    var deck:DeckCore
    @State var deckList = DeckList()
    
    var body: some View {
        ZStack(alignment: .leading){
            HStack(spacing: 10) {
                Image("blackboardM")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 60)
                    .clipShape(Rectangle())
                    .cornerRadius(10)

                VStack(spacing: 3) {
                    
                    Text(deck.unwrappedDeckName)
                        .font(.title).bold()
                        .foregroundColor(.primary)

                    Text("\(deck.numberOfCardsInDeck) cards")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .frame(width: 70)
                
                    Text("created on \(deck.deckCreatedAt ?? "")")
                        .font(.system(size: 12.0))
                        .foregroundColor(.gray)
                        .frame(width: 120)
                }
                Spacer()

            }
            .onAppear {
                deck.numberOfCardsInDeck = Int16(deck.cardsArray.count)
            }
        }

    }
}
