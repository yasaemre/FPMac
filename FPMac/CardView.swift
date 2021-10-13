//
//  CardView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//



import SwiftUI
import Foundation

struct CardView: View {
    @State var cardCore: CardCore
    @State var card: Card
    
    @State var rightArrowTapped = false
    @Binding var flipped:Bool
    @Binding var flip: Bool
    // MARK: - Drawing Constant
    @StateObject var deckCore:DeckCore
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State var correctRate = 0.0
    @Binding var indexCard:Int
    @Binding var correctAnswer:Int
    @Binding var falseAnswer:Int
    
    @Binding var resetBg:Bool
    @Binding var correctA:Double
    
    
    //To avoid Taps during animation..
    
    @EnvironmentObject var homeData: HomeViewModel
    
    
    var body: some View {
        VStack(spacing:20) {
            HStack {
                Button(action: {withAnimation {homeData.isExpanded.toggle()}}) {
                    Image(systemName: "arrowshape.turn.up.backward")
                        .font(.largeTitle)
                        .frame(width: 90, height: 40)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Text("Study")
                    .font(.title)
                    .padding()
            }
            .padding(.trailing, 20)
            
            HStack(spacing: 15) {
                
                Button {
                    withAnimation {
                        flip = false
                    }
                } label: {
                    Text("Word")
                        .font(.custom("Chalkduster", size: 24))
                        .frame(width: 130, height: 40)
                        .background(!flip ? Color.init(hex: "164430") : .gray)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                
                
                Button {
                    withAnimation {
                        flip = true
                    }
                } label: {
                    Text("Meaning")
                        .font(.custom("Chalkduster", size: 24))
                        .frame(width: 130, height: 40)
                        .background(flip ? Color.init(hex: "164430") : .gray)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.top, 20)
            
            ZStack(alignment:.center) {
                Image("bbs1")
                    .resizable()
                    .frame(width: 250, height: 350)
                    .clipped()
                    .cornerRadius(12)
                
                if deckCore.cardsArray.count > 0 {
                    if flip == false {
                        
                        ZStack {
                            Text(deckCore.cardsArray[indexCard].unwrappedWord)
                                .foregroundColor(.white)
                                .font(.custom("Chalkduster", size: 25))
                                .frame(width: 185, height: 340, alignment: .center)
                        }
                    } else {
                        ZStack {
                
                            Text(deckCore.cardsArray[indexCard].unwrappedDefinition)
                                .font(.custom("Chalkduster", size: 25))
                                .frame(width: 185, height: 340, alignment: .center)
                                .foregroundColor(.white)
                        }
                    }
                    
                }
                
                HStack {
                    Image("correct")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:75,height: 75)
                        .offset(x: 140, y: -140)
                        .opacity(Double(card.x/10 - 1))
                    
                    Spacer()
                    Image("false")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:75,height: 75)
                        .offset(x: -140, y: -140)
                        .opacity(Double(card.x/10 * -1 - 1))
                }
                
            }
            .padding(.top, 10)
            .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
            .cornerRadius(8)
            .offset(x: card.x, y: card.y)
            .rotationEffect(.init(degrees: card.degree))
            .gesture (
                DragGesture()
                    .onChanged { value in
                        withAnimation(.default) {
                            card.x = value.translation.width
                            // MARK: - BUG 5
                            card.y = value.translation.height
                            card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                            
                        }
                    }
                    .onEnded { (value) in
                        withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                            switch value.translation.width {
                            case 0...100:
                                card.x = 0; card.degree = 0; card.y = 0
                                
                            case let x where x > 100:
                                card.x = 1000; card.degree = 12
                                correctAnswer += 1
                                correctA += 1
                                if  indexCard > 0 {
                                    indexCard -= 1
                                }
                                self.resetBg = false
                                
                            case (-100)...(-1):
                                card.x = 0; card.degree = 0; card.y = 0
                            case let x where x < -100:
                                card.x  = -1000; card.degree = -12
                                falseAnswer += 1
                                if  indexCard > 0 {
                                    indexCard -= 1
                                    
                                }
                                self.resetBg = false
                                
                                
                            default:
                                card.x = 0; card.y = 0
                                
                            }
                            
                        }
                    }
            )
            
            Text("\(indexCard+1) of \(deckCore.cardsArray.count)")
                .font(.title2)
                .padding(.top, 10)
            
            HStack(spacing: 40){
                
                Text("Correct: \(correctAnswer)")
                    .font(.custom("Chalkduster", size: 22))
                    .frame(width: 150, height: 40)
                    .background(Color.init(hex: "164430"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                
                
                
                Text("False: \(falseAnswer)")
                    .font(.custom("Chalkduster", size: 22))
                    .frame(width: 150, height: 40)
                    .foregroundColor(Color.init(hex: "164430"))
                    .background(Color(.lightGray))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
            }
            
            
            Button {
                //some code
            } label: {
                
                HeartView(resetBg: $resetBg, deckCore:deckCore, indexCard: $indexCard)
                
            }
            .padding(.top, 10)
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
    }
}
