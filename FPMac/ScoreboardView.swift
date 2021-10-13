//
//  ScoreboardView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//


import SwiftUI
import CoreData

struct ScoreboardView: View {
    
    
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckName, ascending: true)],
           animation: .default)
       private var decksArrPersistent: FetchedResults<DeckCore>

    @State private var isShareSheetShowing = false

    
    @State private var selectedDeck: DeckCore

        init(moc: NSManagedObjectContext) {
            let fetchRequest: NSFetchRequest<DeckCore> = DeckCore.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \DeckCore.deckName, ascending: false)]
            fetchRequest.predicate = NSPredicate(value: true)
            self._decksArrPersistent = FetchRequest(fetchRequest: fetchRequest)
            do {
                let tempItems = try moc.fetch(fetchRequest)
                if(tempItems.count > 0) {
                    self._selectedDeck = State(initialValue: tempItems.first!)
                } else {
                    self._selectedDeck = State(initialValue: DeckCore(context: moc))
                    moc.delete(selectedDeck)
                }
            } catch {
                fatalError("Init Problem")
            }
        }
    
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text("Scoreboard")
                .font(.title)
            Spacer()
            
            if (decksArrPersistent.count > 0) {
                Picker("Please choose a deck", selection: $selectedDeck) {
                    ForEach(decksArrPersistent, id: \.self) { (deck:DeckCore) in
                        Text(deck.unwrappedDeckName)
                    }
                }

            }
            Group {
                if (decksArrPersistent.count > 0) {
                Text("The Highest Correct Rate \nfor \(selectedDeck.unwrappedDeckName):")
                    .font(.title)
                    //.foregroundColor(.white)
                }
                Text("% \(String(round(selectedDeck.correctRate)))")
                    .fontWeight(.semibold)
                    .font(.system(size: 54))
                    .foregroundColor(.red)
            }
            .padding(.top, 20)
            Spacer()
        }

    }
}

