//
//  EditView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//

import SwiftUI

struct EditView: View {
    
    @State var flipped = false
    @State var flip = false
    @State var rightArrowTapped = false
    //@State var cardCore: CardCore
    @State var card: Card
    @StateObject var deckCore:DeckCore
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    @StateObject var likedCore:LikedCore
    // @State var correctAnswer = 0
    @State private var rotateCheckMark = 30
    @State private var checkMarkValue = -60
    
    @State private var showCircle = 0
    
    @State private var isShowingCheckMark = false


    
    
    var body: some View {
        ZStack {
            VStack{
                
                HStack {
                    Spacer()

//
//                    NavigationLink(destination:  StudyScreenView(deckCore: deckCore, card: card)) {
//                        Text("Study")
//                            .font(.title)
//                            .foregroundColor(Color.init(hex: "B74278"))
//                            .padding(.trailing, 1)
//                            .onTapGesture {
//                                print("study tapped")
//                            }
//                    }
//                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
                        print("study tapped")
                        print("\(deckCore.cardsArray.count)")
                            }, label: {
                                Text("Study")
                                    .font(.title)
                                    .foregroundColor(Color.init(hex: "B74278"))
                                    .padding(.trailing, 1)
                                   
                            })
                            .background(
                                NavigationLink(
                                    destination: StudyScreenView(deckCore: deckCore, card: card),
                              
                                   
                                    label: { EmptyView() }
                                )
                            )
                            .buttonStyle(PlainButtonStyle())


                }
                .padding(.trailing, 20)
                
                
                HStack(spacing: 15) {
                    
                    Button {
                        withAnimation {
                            flip = false
                            print("Index in Editiew: \(indexCard)")
                        }
                    } label: {
                        Text("Word")
                            .font(.title)
                            .frame(width: 130, height: 40)
                            .background(!flip ? Color.init(hex: "1130C1") : .gray)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                        
                        
                    }
                    .buttonStyle(PlainButtonStyle())

                    
                    Button {
                        withAnimation {
                            flip = true
                            //saveContext()
                        }
                    } label: {
                        Text("Meaning")
                            .font(.title)
                            .frame(width: 130, height: 40)
                            .background(flip ? Color.init(hex: "1130C1") : .gray)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())

                }
                .padding(.top, 20)
                
                if flipped == true {
                    
                    TextField("Enter a word", text: $card.word)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.top, 1)
                    //                        .padding(.leading, 40)
                    //                        .padding(.trailing, 40)
                        .frame(width: 250, height: 145, alignment: .center)
                        //.textFieldStyle(.roundedBorder)
                        .modifier(TextFieldClearButton(text: $card.word))
                } else {
                    TextField("Enter a definition", text: $card.definition)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.top, 1)
                    //                        .padding(.leading, 40)
                    //                        .padding(.trailing, 40)
                        .frame(width: 250, height: 145, alignment: .center)
                        //.textFieldStyle(.roundedBorder)
                        .modifier(TextFieldClearButton(text: $card.definition))
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "1130C1"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 250, height: 350)
                    .shadow(color: Color(NSColor(.black)), radius: 10, x: 5, y: 5)
                    .overlay(
                        VStack( spacing: 5) {
                        if deckCore.cardsArray.count > 0 {
                            if flip == false {
                                if rightArrowTapped == true {
                                    Text("")
                                } else {
                                    Text(deckCore.cardsArray[indexCard].unwrappedWord)
                                        .font(.custom("HelveticaNeue", size: 40))
                                        .foregroundColor(.white)
                                        .overlay(Image(systemName: "minus.circle.fill")
                                                    .font(.title)
                                                    .foregroundColor(Color(.systemGray))
                                                    .offset(x: -123, y: -175)
                                                    .onTapGesture{
                                            alertViewDeleteCard(at: IndexSet.init(integer: indexCard))
                                        })
                                }
                            } else {
                                //                                if rightArrowTapped == true {
                                //                                    Text("")
                                //                                } else {
                                Text(deckCore.cardsArray[indexCard].unwrappedDefinition)
                                    .font(.custom("HelveticaNeue", size: 40))
                                    .foregroundColor(.white)
                                    .overlay(Image(systemName: "minus.circle.fill")
                                                .font(.title)
                                                .foregroundColor(Color(.systemGray))
                                                .offset(x: -123, y: -175)
                                                .onTapGesture{
                                        //deleteDeck(at: IndexSet.init(integer: index))
                                        alertViewDeleteCard(at: IndexSet.init(integer: indexCard))
                                    })
                                //}
                            }
                        } else {
                            ForEach(0..<deckCore.cardsArray.count, id:\.self) { index in
                                if flip == false {
                                    //                                if rightArrowTapped == true {
                                    //                                    Text("")
                                    //                                } else {
                                    Text(deckCore.cardsArray[index].unwrappedWord)
                                        .font(.custom("HelveticaNeue", size: 40))
                                        .foregroundColor(.white)
                                        .overlay(Image(systemName: "minus.circle.fill")
                                                    .font(.title)
                                                    .foregroundColor(Color(.systemGray))
                                                    .offset(x: -123, y: -175)
                                                    .onTapGesture{
                                            //deleteDeck(at: IndexSet.init(integer: index))
                                            alertViewDeleteCard(at: IndexSet.init(integer: index))
                                        })
                                    
                                    
                                    //}
                                } else {
                                    //                                if rightArrowTapped == true {
                                    //                                    Text("")
                                    //                                } else {
                                    Text(deckCore.cardsArray[index].unwrappedDefinition)
                                        .font(.custom("HelveticaNeue", size: 40))
                                        .foregroundColor(.white)
                                        .overlay(Image(systemName: "minus.circle.fill")
                                                    .font(.title)
                                                    .foregroundColor(Color(.systemGray))
                                                    .offset(x: -123, y: -175)
                                                    .onTapGesture{
                                            //deleteDeck(at: IndexSet.init(integer: index))
                                            alertViewDeleteCard(at: IndexSet.init(integer: index))
                                        })
                                    //}
                                }
                                
                                
                                
                                
                            }
                        }
                        
                        
                    }
                        
                    )
                    .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
                    .padding(.top, 5)
                
                
                Text("\(indexCard+1) of \(deckCore.cardsArray.count)")
                    .font(.title2)
                    .padding(.top, 10)
                
                HStack(spacing: 30){
                    Button {
                        if  indexCard >= 1 {
                            indexCard -= 1
                        }
                    } label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .font(.largeTitle)
                            .foregroundColor(Color.init(hex: "B74278"))
                    }
                    .buttonStyle(PlainButtonStyle())

                    
                    Button {
                        
                        withAnimation{
                            isShowingCheckMark.toggle()
                        }
                        
                        addCard()
                        
                    } label: {
                        Text("Add Card")
                            .font(.title)
                            .frame(width: 150, height: 60)
                            .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "1130C1"), Color.init(hex: "B74278")]),  center: .center, startRadius: 5, endRadius: 120))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                    }
                    .buttonStyle(PlainButtonStyle())

                    
                    
                    Button {
                        //
                        if indexCard
                            != deckCore.cardsArray.count-1, !deckCore.cardsArray.isEmpty {
                            indexCard += 1
                        }
                    } label: {
                        Image(systemName: "arrowshape.turn.up.right")
                            .font(.largeTitle)
                            .foregroundColor(Color.init(hex: "B74278"))
                    }
                    .buttonStyle(PlainButtonStyle())

                }
            }
            
            if isShowingCheckMark {
                ZStack {
                Circle()
                    .frame(width: 110, height: 110, alignment: .center)
                    .foregroundColor(.white)
                    .opacity(0.5)
                    .scaleEffect(CGFloat(showCircle))
                    .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.5))
                    .transition(.asymmetric(insertion: .opacity, removal: .scale))

                    

                    
                Image(systemName: "checkmark")
                        .foregroundColor(Color.init(hex: "067238"))
                    .font(.system(size: 60))
                    .rotationEffect(.degrees(Double(rotateCheckMark)))
                    .clipShape(Rectangle().offset(x: CGFloat(checkMarkValue)))
                    .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.75))
                    .transition(.asymmetric(insertion: .opacity, removal: .scale))
                }
                .onAppear(perform: setDismissTimer)
            }

            
                   
            
        }
        
    }
    func setDismissTimer() {
      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
        withAnimation(.easeInOut(duration: 2)) {
          self.isShowingCheckMark = false
        }
        timer.invalidate()
      }
      RunLoop.current.add(timer, forMode:RunLoop.Mode.default)
        card.word = ""
        card.definition = ""
    }
    
    private func addCard() {
        
        let newCard = CardCore(context: viewContext)
        newCard.word = card.word
        newCard.definition = card.definition
        newCard.imageName = "cardBackg"

        deckCore.addToCards(newCard)
        PersistenceController.shared.saveContext()
        showCircle = 1
        rotateCheckMark = 0
        checkMarkValue = 0
            
        //UserDefaults.standard.set(self.indexOfCard, forKey: "indexOfCard")
        //print("\(Int(newCard.numOfCard))")
                for card in deckCore.cardsArray {
                    print(card.word)
                    print(card.definition)
                }
        
        
        
    }
    
    //Use with tap gesture or delete button
    private func deleteCard(at offsets: IndexSet) {
        withAnimation {
            
            for index in offsets {
                let card = deckCore.cardsArray[index]
                viewContext.delete(card)
                PersistenceController.shared.saveContext()
            }
        }
    }
    
    func alertViewDeleteCard(at index: IndexSet) {
        Alert(title: Text("Delete Card"),
               message: Text("Do you want to delete this card?"),
               primaryButton: .default(Text("Delete"), action: {
                deleteCard(at: index)

        }), secondaryButton: .cancel(Text("Cancel"), action: {
            //same
        }))    }
}

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                    Image(systemName: "delete.left")
                        //.foregroundColor(NSColor(NSColor.opaqueSeparator))
                }
                )
            }
        }
    }
}

struct FlipEffect: GeometryEffect {
    
    @Binding var flipped:Bool
    var angle:Double
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            flipped = angle >= 90 && angle < 270
        }
        let newAngle = flipped ? -180 + angle : angle
        
        let angleInRadians = CGFloat(Angle(degrees: newAngle).radians)
        
        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1/max(size.width, size.height)
        transform3d = CATransform3DRotate(transform3d, angleInRadians, 0, 1, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width / 2, -size.height/2, 0)
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width / 2, y: size.height / 2))
        
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}




//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}