//
//  HomeView.swift
//  FlashPadMac
//
//  Created by Emre Yasa on 9/24/21.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                    .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            HStack {
                Image(systemName: "magnifiyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $homeData.search)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.primary.opacity(0.15))
            .cornerRadius(10)
            .padding()
            
            List(selection: $homeData.selectedRecentMsg) {
                ForEach(homeData.msgs) { message in
                    // Message view
                    NavigationLink(destination: DetailView( user: message), label: {
                        RecentCardView(recentMsg: message)
                    })
                }
            }
            .listStyle(SidebarListStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
