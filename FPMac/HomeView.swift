//
//  HomeView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/22/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeData: HomeViewModel
    

    @State var selectedTab = "home"
    @State var xAxis:CGFloat = 0
    @Namespace var animation
    
    @State var customAlert = false
    @State var HUD = false
    
    @State var dark = false
    @State var show = false
    @Environment(\.colorScheme) var colorScheme
    @State var deck = Deck()
    @State var card = Card()
    
    @State private var navBarHidden = false
   @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckCreatedAt, ascending: false)],
           animation: .default)
       private var decksArrPersistent: FetchedResults<DeckCore>
    @StateObject var likedCore = LikedCore()
  
    @State private var deckName = ""
    @Binding  var deckCreatedAt:String
    @Binding  var numOfCardsInDeck:Int
    @State private var currentTotalNumOfCards = 0
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \LikedCore.word, ascending: true)],
           animation: .default)
       private var likedArrPersistent: FetchedResults<LikedCore>

  @State private var indexOfCard = UserDefaults.standard.integer(forKey: "indexOfCard")
   // var editScreenView = EditScreenView()
    @StateObject var deckCore = DeckCore()
    @State private var calendarWiggles = false
    @State var imageHasChanged = false
    @State private var avatarImageData:Data? = Data()
    @State private var avatarImage = Image("profilePhoto")
    @State private var sheetIsShowing = false
    @State private var dialogResult = ""
    
    let columns = Array(repeating: GridItem(.flexible(), spacing:15), count: 2)
    
    @EnvironmentObject var deckList: DeckList
    @State private var selectedDeck: DeckCore? = nil
    @State private var showAddSheet = false
    @State private var showDeleteAlert = false
    
    @State private var addButtonClicked = false
    
    @State private var showAlertForNotSelectedDeck = false
    @State private var dialogResultForSelection = ""
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    VStack(spacing: 30) {
        
                        HStack {
        
                            Spacer()
        
        
                            Button {
                                sheetIsShowing.toggle()
                                addButtonClicked.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                        .onAppear {
                                for deck in self.decksArrPersistent {
                                    self.deckList.decks.append(deck)
                                }
                        }
        
                        if addButtonClicked {
                            List(0..<decksArrPersistent.count, id: \.self) { index in
            
                                NavigationLink(destination: EditScrnView(card: card, deckCore: decksArrPersistent[index], likedCore: likedCore), tag: decksArrPersistent[index], selection: $selectedDeck){
                                    
                                    DeckListRow(deck: decksArrPersistent[index])
                                    Spacer()
                                    Button {
                                        if let selectedDeckName = selectedDeck?.unwrappedDeckName{
                                            deleteDeck(at: IndexSet.init(integer: index), deleteDeckName: selectedDeckName)
                                            showAlertForNotSelectedDeck = false
                                        } else  {
                                            showAlertForNotSelectedDeck = true
                                        }
                                       
                                    } label: {
                                        Image(systemName: "trash")
                                            .font(.title)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }

                                
                            }
                            .listStyle(SidebarListStyle())
                        } else {
                            List(0..<deckList.decks.count, id: \.self) { index in
            
                                NavigationLink(destination: EditScrnView(card: card, deckCore: deckList.decks[index], likedCore: likedCore), tag: deckList.decks[index], selection: $selectedDeck){
                                    
                                    DeckListRow(deck: deckList.decks[index])
                                    Spacer()

                                    Button {
                                        if let selectedDeckName = selectedDeck?.unwrappedDeckName{
                                            deleteDeck(at: IndexSet.init(integer: index), deleteDeckName: selectedDeckName)
                                            showAlertForNotSelectedDeck = false
                                        } else  {
                                            showAlertForNotSelectedDeck = true
                                        }
                                       
                                    } label: {
                                        Image(systemName: "trash")
                                            .font(.title)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }

                            }
                            .listStyle(SidebarListStyle())
                        }
                        
                        
                    }

                    .sheet(isPresented: $sheetIsShowing) {
                        SheetView(isVisible: self.$sheetIsShowing, enteredText: self.$dialogResult, addButtonClicked: $addButtonClicked)
                    }
                    .alert(isPresented: $showAlertForNotSelectedDeck) {
                        notSelectedRowAlert()
                    }
                    .onDisappear {
                        deckList.decks = []
                    }
            
        }

    }

    func notSelectedRowAlert() -> Alert {
        Alert(title: Text("Delete Deck"),
                     message: Text("Select a deck row before clicking Delete."),
                     dismissButton: .default(Text("OK")))
    }
    
    //Use with tap gesture or delete button
    private func deleteDeck(at offsets: IndexSet, deleteDeckName: String) {
        

        guard let deleteDeckName = selectedDeck?.deckName, let deckIndex = deckList.decks.firstIndex(where: { deck in
            deck.unwrappedDeckName == deleteDeckName
        }) else {
            return
        }
        
        withAnimation {
                let deck = decksArrPersistent[deckIndex]
                deckList.decks.remove(at: deckIndex)
                viewContext.delete(deck)
                PersistenceController.shared.saveContext()
        }
        
    }
}

class DeckList: ObservableObject {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckCreatedAt, ascending: false)],
           animation: .default)
       private var decksArrPersistent: FetchedResults<DeckCore>
    @Published var decks: [DeckCore] = []
   
    
    
    func remove(deleteDeckName: String, at offsets: IndexSet) {
        guard let deckIndex = decks.firstIndex(where: { deck in
            deck.unwrappedDeckName == deleteDeckName
        }) else {
            return
        }

        decks.remove(at: deckIndex)

        
        for index in offsets {
            if deckIndex == index {
            let deck = decksArrPersistent[index]
            
            viewContext.delete(deck)
            PersistenceController.shared.saveContext()
            }
        }
    }
}
struct CustomShape:Shape {
    var xAxis: CGFloat
    
    var animatableData: CGFloat {
        get { return xAxis }
        set {xAxis = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center-50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center-25, y: 0)
            let control2 = CGPoint(x: center-25, y: 35)
            
            let to2 = CGPoint(x: center+50, y: 0)
            let control3 = CGPoint(x: center+25, y: 35)
            let control4 = CGPoint(x: center+25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct SheetView: View {
    @Binding var isVisible: Bool
    @Binding var enteredText: String
    @Environment(\.managedObjectContext) private var viewContext

    @State var deck = Deck()
    @State private var deckName = ""
    @State  var deckCreatedAt = ""
    @State  var numOfCardsInDeck = 0
    @State private var indexOfCard = UserDefaults.standard.integer(forKey: "indexOfCard")
  
    @Binding var addButtonClicked:Bool

    var body: some View {
        VStack {
            Text("Create FlashPad Deck")
                .font(.headline)
                .multilineTextAlignment(.center)

            TextField("Enter the name of the deck here", text: $enteredText)
                 .padding()

            HStack {
                Button("Cancel") {
                    self.isVisible = false
                    self.enteredText = "Cancel clicked in Sheet"
                }
                Spacer()
              
                
                Button {
                    
                    self.isVisible = false
                    
                    self.deckName = enteredText
                    
                    self.numOfCardsInDeck = Int(Int16(indexOfCard))
                    self.deckCreatedAt = deck.getTodayDate()
                    addDeck()
                } label: {
                   Text("Create")
                }

            }
        }
        .frame(width: 300, height: 200)
        .padding()
    }
    
    
     func addDeck() {
        indexOfCard = 0
        let newDeck = DeckCore(context: viewContext)

        
        newDeck.deckName = deckName
        newDeck.numberOfCardsInDeck = Int16(numOfCardsInDeck)
         newDeck.deckCreatedAt = deckCreatedAt
         newDeck.id = UUID()
         
         PersistenceController.shared.saveContext()
         addButtonClicked = true
     }
    
    
}
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            Home()
        }
    }
    

