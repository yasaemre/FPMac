//
//  DetailView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/22/21.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var user: RecentMessage
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(user.userName)
                        .font(.title2)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Button(action: {withAnimation {homeData.isExpanded.toggle()}}) {
                        Image(systemName: "sidebar.right")
                            .font(.title2)
                            .foregroundColor(homeData.isExpanded ? .blue : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
                .padding()
                
                Spacer()
                
                HStack(spacing:15) {
                    Button(action: {}) {
                        Image(systemName: "paperplane")
                            .font(.title2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    TextField("Enter Message", text: $homeData.message)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.vertical,8)
                        .padding(.horizontal)
                        .clipShape(Circle())
                        .background(Capsule().strokeBorder(Color.white))
                    
                    Button(action: {}) {
                        Image(systemName: "face.smiling.fill")
                            .font(.title2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {}) {
                        Image(systemName: "mic")
                            .font(.title2)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding([.horizontal, .bottom])
            }
            ExpandedView(user: user)
                .background(BlurView())
                .frame(width: homeData.isExpanded ? nil : 0)
                .opacity(homeData.isExpanded ? 1 : 0)
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct ExpandedView: View {
    var user: RecentMessage
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        HStack(spacing:0) {
            Divider()
            
            VStack(spacing: 25) {
                Image(user.userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:90, height: 90)
                    .clipShape(Circle())
                    .padding(.top, 35)
                
                Text(user.userName)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "bell.slash")
                                .font(.title2)
                            Text("Mute")
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "hand.raised.fill")
                                .font(.title2)
                            Text("Block")
                        }
                        .contentShape(Rectangle())

                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "exlamationmark.triangle")
                                .font(.title2)
                            Text("Report")
                        }
                        .contentShape(Rectangle())

                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .foregroundColor(.gray)
                
                Picker(selection: $homeData.pickedTab, label: Text("Picker"), content: {
                    Text("Media").tag("Media")
                    Text("Links").tag("Links")
                    Text("Audio").tag("Audio")
                    Text("Files").tag("Files")
                })
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
                    .padding(.vertical)
                
                ScrollView {
                    if homeData.pickedTab == "Media" {
                        
                    } else {
                        Text("No \(homeData.pickedTab)")
                    }
                }
                
            }
            .padding(.horizontal)
            .frame(maxWidth: 300)
        }
    }
}
