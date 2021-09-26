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
    //@State var nameOfDeck = ""
    
    @State var dark = false
    @State var show = false
        
    @Environment(\.colorScheme) var colorScheme
    @State var deck = Deck()
    @State var card = Card()
    let columns = Array(repeating: GridItem(.flexible(), spacing:25), count: 2)
    
    @State private var navBarHidden = false
   // @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
   @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckName, ascending: true)],
           animation: .default)
       private var decksArrPersistent: FetchedResults<DeckCore>
    @StateObject var likedCore = LikedCore()
   // @State var imageHasChanged = false
    //@State var indexCard = 0
    //@Binding var indexCard:Int
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
    //@State private var selection = ""
    var body: some View {
        VStack(spacing: 30) {
            
            HStack {
               
                Spacer()
                
                
                Button {
                    sheetIsShowing.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .onAppear {
                print("\(decksArrPersistent.count)")
            }
            
    
            
            List(selection:$homeData.selectedRecentMsg) {
                ForEach(0..<decksArrPersistent.count, id: \.self) { index in
                
                    NavigationLink(destination: EditScrnView(card: card, deckCore: decksArrPersistent[index], likedCore: likedCore)){

                        HStack(spacing: 10) {
                                    Image("cardBackg")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 60)
                                        .clipShape(Rectangle())
                                        .cornerRadius(10)
                            

                            
                            VStack(spacing: 3) {
                              
                                Text(decksArrPersistent[index].unwrappedDeckName)
                                    .font(.title).bold()
                                    .foregroundColor(.black)
                                
                                Text("\(decksArrPersistent[index].numberOfCardsInDeck) cards")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .onAppear {
                                        decksArrPersistent[index].numberOfCardsInDeck = Int16(decksArrPersistent[index].cardsArray.count)
                                    }
                                Text("created on \(decksArrPersistent[index].deckCreatedAt ?? "")")
                                    .font(.system(size: 12.0))
                                    .foregroundColor(.gray)
                                Spacer()
                                    .onAppear {
                                        print("\(String(describing: decksArrPersistent[index].deckCreatedAt))")
                                        print("\(decksArrPersistent[index].numberOfCardsInDeck) cards")
                                    }
                            }
                            
                            Spacer()
                            Button {
                                    deleteDeck(at: IndexSet.init(integer: index))
                            } label: {
                                Image(systemName: "trash")
                                    .font(.title)
                            }
                            .buttonStyle(PlainButtonStyle())

                        }
                     
                    }
                    
               }
//                .onDelete(perform: onDelete)
            }
            .listStyle(SidebarListStyle())
            
//            .onDeleteCommand {
//                if let sel = self.selection, let idx = self.decksArrPersistent.firstIndex(where: selection) {
//                           print("delete item: \(sel)")
//                           self.viewContext.delete(decksArrPersistent[idx])
//                       }
            
            
          
        }
        .sheet(isPresented: $sheetIsShowing) {
              SheetView(isVisible: self.$sheetIsShowing, enteredText: self.$dialogResult)
          }
       
        
    }

    
    
    //Use with tap gesture or delete button
    private func deleteDeck(at offsets: IndexSet) {
        withAnimation {
//            offsets.map {decksArrPersistent[$0]}.forEach(viewContext.delete)
            for index in offsets {
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
        
        PersistenceController.shared.saveContext()

    }


}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

