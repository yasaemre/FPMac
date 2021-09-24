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

    var body: some View {
        HStack(spacing: 0) {
            VStack{
                //tab button
                
                TabButton(image: "house", title: "Home", selectedTab: $homeData.selectedTab)
                TabButton(image: "textformat.123", title: "Scoreboard", selectedTab: $homeData.selectedTab)
                TabButton(image: "heart.circle", title: "Liked Cards", selectedTab: $homeData.selectedTab)
                TabButton(image: "square.text.square", title: "Instructions", selectedTab: $homeData.selectedTab)
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
                default: Text("")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
         
        }

        .ignoresSafeArea(.all, edges: .all)
        .frame(width: screen.width / 1.8, height: screen.height-150)
        .environmentObject(homeData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
