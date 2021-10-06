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
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//
//                        deck.numberOfCardsInDeck = Int16(deck.cardsArray.count)
//
//                        }
//                    }
            
                Text("created on \(deck.deckCreatedAt ?? "")")
                    .font(.system(size: 12.0))
                    .foregroundColor(.gray)
                Spacer()

            }
        }
        .onAppear {
            deck.numberOfCardsInDeck = Int16(deck.cardsArray.count)
        }
    }
}

//struct DeckListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DeckListRow()
//    }
//}
