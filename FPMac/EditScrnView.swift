//
//  EditScrnView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//


import SwiftUI

struct EditScrnView: View {
    
    @State var card =  Card()
    @StateObject var deckCore = DeckCore()
    //@State var cardCore: CardCore
    //@State var cardCore: CardCore
   // @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    @AppStorage("indexCard") var indexCard = 0

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckCreatedAt, ascending: false)],
//        animation: .default)
//    private var decksArrPersistent: FetchedResults<DeckCore>
    @StateObject var likedCore:LikedCore

    var body: some View {
        ZStack(){
            EditView(card: card, deckCore: deckCore, likedCore: likedCore)
                .onAppear(perform: {
                
                     if deckCore.cardsArray.isEmpty {
                        indexCard = deckCore.cardsArray.count
                     }
                    else if indexCard == 0 {
                        indexCard = 0
                    }
                    else {
                        indexCard = deckCore.cardsArray.count-1
                    }
                    print("Index in EditScrnView: \(indexCard)")
                })
        }
      
     
        .zIndex(1.0)
        
        
    }
}

//struct EditScrnView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditScrnView()
//    }
//}

