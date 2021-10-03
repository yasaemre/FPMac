//
//  Home.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/22/21.
//

import SwiftUI


var screen = NSScreen.main!.visibleFrame
struct Home: View {
    @StateObject var homeData = HomeViewModel()
    @State private var deckCreatedAt = ""
    @State private var numOfCardsInDeck = 0
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>

    var body: some View {
        HStack(spacing: 0) {
            VStack{
                //tab button
                if let data = profileArrPersistent.last?.image {
                    Image(nsImage: NSImage(data: data)!)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                }
                HStack(spacing:1) {
                    Text(profileArrPersistent.last?.name ?? "Anonymous")
                        .foregroundColor(.gray)
                    Text(profileArrPersistent.last?.lastName ?? "Anonymous")
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)
                TabButton(image: "house", title: "Home", selectedTab: $homeData.selectedTab).padding(.top, 30)
                TabButton(image: "textformat.123", title: "Scoreboard", selectedTab: $homeData.selectedTab)
                TabButton(image: "heart.circle", title: "Liked Cards", selectedTab: $homeData.selectedTab)
                TabButton(image: "doc.text.magnifyingglass", title: "Instructions", selectedTab: $homeData.selectedTab)
                TabButton(image: "person.crop.circle", title: "Profile", selectedTab: $homeData.selectedTab)
                Spacer()
                
                //TabButton(image: "gear", title: "Settings", selectedTab: $homeData.selectedTab)
            }
            .padding()
            .padding(.top, 35)
            .background(BlurView())
            
            
            //Tab Content
            
            ZStack {
                switch homeData.selectedTab {
                case "Home": NavigationView{ HomeView(deckCreatedAt: $deckCreatedAt, numOfCardsInDeck: $numOfCardsInDeck)}
                case "Scoreboard": NavigationView { ScoreboardView(moc: viewContext)}
                case "Liked Cards": NavigationView { LikedCardView()}
                case "Instructions": NavigationView {IntsructionsView()}
                case "Profile": NavigationView {ProfileView()}
                default: Text("")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
         
        }

        .ignoresSafeArea(.all, edges: .all)
        .frame(width: screen.width / 1.6, height: screen.height-150)
        .environmentObject(homeData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
class GameSettings: ObservableObject {
    @Published var totalCardInDeck = 0
 
}
