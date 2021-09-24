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
        ZStack(alignment: .top){
            Color.init(hex:"81329b")
                .ignoresSafeArea(.all, edges: .all)
            Image("worldMap")
                .resizable()
                .scaledToFit()
                .padding(.top, 1)
            
            VStack {
//                Text("FLASHPADS")
//                    .bold()
//                    .font(.largeTitle)
//                    .foregroundColor(.gray)
//                    .multilineTextAlignment(.center)
                    //.frame(width: UIScreen.main.bounds.width - 40, height: 70)
                    //.padding(.bottom, 20)
                Spacer()
                
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "F7F2F2"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 300, height:400)
                        .shadow(color: Color(NSColor(.black)), radius: 10, x: 5, y: 5)
                        .overlay(
                            
                            ScrollView{
                                Group {
                                    VStack {
                                        Text("How to use Flashpads")
                                            .bold()
                                            .font(.system(size: 28))
                                            .padding()
                                            .lineLimit(2)
                                        

                                        
                                        Text("Create Deck")
                                            .bold()
                                            .font(.system(size: 24))
                                        Text("On the home screen, click the plus button to create new deck. To populate the deck with flash cards tap the deck and navigate the edit screen. ")
                                        Text("Edit Deck")
                                            .bold()
                                            .font(.system(size: 24))
                                        Text("On the edit screen, while word button is clicked, tap to text field to enter the word and then tap the meaning button to type the meaning of the word and finally click the add card button. The word is succesfully added to the deck. Clear the text field tapping the clear button next to text field. ")
                                        Text("Study Deck")
                                            .bold()
                                            .font(.system(size: 24))
                                        Text("Swipe card to the right if you know the meaning of the word, swipe left if you don't know. Depending on the your self-check you cand find your correction rate of related deck on scroboard screen.")
                                        Text("Liked Cards")
                                            .bold()
                                            .font(.system(size: 24))
                                        Text("While studying the card clicked the like button to all the cards you liked on on liked screen. Click like button on tab bar to move liked cards screen on home screen.")
                                    }
                                  
                                }
                                .frame(width: 200)
                                .foregroundColor(.black)
                            
                             Spacer()
                            
                        }
                            
                        )
                        .opacity(0.8)
                        .padding(.top, 10)
               
                
                
                Spacer()
            }
            .padding(.top, 20)
        }
      
        
    }
}

struct IntsructionsView_Previews: PreviewProvider {
    static var previews: some View {
        IntsructionsView()
    }
}
