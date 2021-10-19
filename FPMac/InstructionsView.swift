//
//  InstructionsView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//
//


import SwiftUI

struct IntsructionsView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top){
                Color.init(hex:"81329b")
                    .ignoresSafeArea(.all, edges: .all)
                Image("worldMap")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 1)
                
                VStack {
                                        
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "F7F2F2"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: geo.size.width * 0.8, height:geo.size.height * 0.9)
                        .shadow(color: Color(NSColor(.black)), radius: 10, x: 5, y: 5)
                        .overlay(
                            
                                Group {
                                    VStack {
                                        Text("How to use Flashpads")
                                            .bold()
                                            .font(.system(size: geo.size.height * 0.03))
                                            .padding(.top, geo.size.height * 0.02)
                                            .padding(.bottom, geo.size.height * 0.02)
                                        Text("Create Deck")
                                            .bold()
                                            .font(.system(size: geo.size.height * 0.02))
                                        Text("On the home screen, click the plus button to create a new deck. To populate the deck with flash cards, tap the deck and navigate the edit screen. ")
                                            .font(.system(size: geo.size.height * 0.02))

                                        Text("Edit Deck")
                                            .bold()
                                            .font(.system(size: geo.size.height * 0.02))
                                        Text("On the edit screen, while word button is clicked, tap to text field to enter the word and then tap the meaning button to type the meaning of the word and finally click the add card button. The word will be succesfully added to the deck. Clear the text field tapping the clear button next to text field.")
                                            .font(.system(size: geo.size.height * 0.02))

                                        Text("Study Deck")
                                            .bold()
                                            .font(.system(size: geo.size.height * 0.02))
                                        Text("Swipe card to the right if you know the meaning of the word, swipe left if you don't. Depending on the your self-assessment you cand find your correction rate of related deck on scroboard screen.")
                                            .font(.system(size: geo.size.height * 0.02))

                                        Text("Liked Cards")
                                            .bold()
                                            .font(.system(size: geo.size.height * 0.02))
                                        Text("While studying a deck, pick the card you like by clicking heart button. The card you liked on each deck will show up on liked screen all togather. Liked screen is the one having heart icon on tab bar on home screen.")
                                            .font(.system(size: geo.size.height * 0.02))

                                    }
                                    
                                }
                                .frame(width: geo.size.width * 0.7, height:geo.size.height * 0.8)
                                .foregroundColor(.black)
                                
                            
                            
                        )
                        .opacity(0.8)
                        .padding(.top, geo.size.height * 0.02)
                    
                    
                    
                    //Spacer()
                }
                .padding(.top, geo.size.height * 0.02)
            }
        }
        
    }
}

struct IntsructionsView_Previews: PreviewProvider {
    static var previews: some View {
        IntsructionsView()
    }
}
