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
    // @State var card: Card
    // MARK: - Drawing Constant
    @StateObject var deckCore:DeckCore
   
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State var correctRate = 0.0
        // @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
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
                .onAppear {
                    print("indexCard in cardView = \(indexCard)")
                    print("deckCore.cardsArray.count = \(deckCore.cardsArray.count)")
                }

            }
            .padding(.top, 20)
            
            ZStack(alignment:.center) {
                Image("bbS")
                    .resizable()
                    .frame(width: 250, height: 350)
                    .clipped()
                    .cornerRadius(12)

                if deckCore.cardsArray.count > 0 {
                    if flip == false {

                        ZStack {
                            Text(deckCore.cardsArray[indexCard].unwrappedWord)
                                .font(.custom("Chalkduster", size: 40))
                                .foregroundColor(.white)
                        }
                        .onAppear {
                            print("flip of word in cardView : \(flip)")
                            print("indexCard of word in cardView : \(indexCard)")
                            print("deckCore.cardsArray.count word in cardView : \(deckCore.cardsArray.count)")
                        }




                    } else {
                        ZStack {

                            Text(deckCore.cardsArray[indexCard].unwrappedDefinition)
                                .font(.custom("Chalkduster", size: 40))
                                .foregroundColor(.white)
                                .onAppear {
                                    print("flip of def in cardView : \(flip)")
                                    print("indexCard def in cardView : \(indexCard)")
                                    print("deckCore.cardsArray.count def in cardView : \(deckCore.cardsArray.count)")
                                }
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
                        //self.animationActivated = false

                    case let x where x > 100:
                        card.x = 1000; card.degree = 12
                        correctAnswer += 1
                        correctA += 1
                        if  indexCard > 0 {
                            indexCard -= 1
                        }
                       // self.isTapped = true
                        self.resetBg = false

                    case (-100)...(-1):
                        card.x = 0; card.degree = 0; card.y = 0
                    case let x where x < -100:
                        card.x  = -1000; card.degree = -12
                        falseAnswer += 1
                        if  indexCard > 0 {
                            indexCard -= 1

                        }
                       // self.isTapped = true
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
              //  let newLikedCard = PersonCore(context: viewContext)
               
                print("Like button tapped")
            } label: {
                
                HeartView(resetBg: $resetBg, deckCore:deckCore, indexCard: $indexCard)

            }
            .padding(.top, 10)
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
    }
}

//Custom shape for resetting center
//struct CustomShapeLike: Shape {
//    var radius: CGFloat
//
//    var animatableData: CGFloat {
//        get { return radius}
//        set { radius = newValue }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        return Path { path in
//            path.move(to: CGPoint(x: 0, y: 0))
//            path.addLine(to: CGPoint(x: 0, y: rect.height))
//            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
//            path.addLine(to: CGPoint(x: rect.width, y: 0))
//
//            //adding center to circle
//            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
//            path.move(to: center)
//            path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .init(degrees: 360), clockwise: false)
//        }
//    }

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: DeckCore.cardsArray[0])
//                    .previewLayout(.sizeThatFits)
//    }
//}
