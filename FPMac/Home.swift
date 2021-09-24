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
                case "Home": NavigationView{ HomeView()}
                case "Scoreboard": Text("Scoreboard")
                case "Liked Cards": Text("Liked Cards")
                case "Instructions": Text("Instructions")
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
