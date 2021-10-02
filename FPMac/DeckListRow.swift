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
            Image("cardBackg")
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
                    .onAppear {
                        if deckList.decks.count != deck.numberOfCardsInDeck {
                            deck.numberOfCardsInDeck = Int16(deckList.decks.count)
                        }
                    }
                    
//                                            .onAppear {
//                                                deckList.decks[index].numberOfCardsInDeck = Int16(deckList.decks[index].cardsArray.count)
//                                            }
                Text("created on \(deck.deckCreatedAt ?? "")")
                    .font(.system(size: 12.0))
                    .foregroundColor(.gray)
                Spacer()
                    .onAppear {
//                                                print("\(String(describing: deck.deckCreatedAt))")
//                                                print("\(deckList.decks[index].numberOfCardsInDeck) cards")
                    }
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
