//
//  LikedCardView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//

import SwiftUI

struct LikedCardView: View {
    
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \LikedCore.word, ascending: true)],
           animation: .default)
       private var likedArrPersistent: FetchedResults<LikedCore>
    @State var offset:CGFloat = 0.0
    
    @State var scrolled = 0
    @State var flipped = false
    @State var flip = false
    @State var correctAnswer = 0
    @State var falseAnswer = 0

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        
        VStack(spacing:5) {
            Spacer()

            HStack(spacing: 15) {
                
                Button {
                    withAnimation {
                        flip = false
                    }
                } label: {
                    Text("Word")
                        .font(.custom("Chalkduster", size: 22))
                        .frame(width: 130, height: 40)
                        .background(!flip ? Color.init(hex: "164430") : .gray)
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
                        .font(.custom("Chalkduster", size: 22))
                        .frame(width: 130, height: 40)
                        .background(flip ? Color.init(hex: "164430") : .gray)

                        .clipShape(Capsule())
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())

            }
            .padding(.bottom, 20)
            .padding(.top, 5)
            
            
            ZStack(alignment: .center){
                ForEach((0..<likedArrPersistent.count).reversed(), id: \.self) { index in
                    
                    HStack {
                        ZStack (alignment: .center){
                            Image("bbS")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: calculateWidth(), height: 400 - CGFloat(index-scrolled)*50)
                                .cornerRadius(15)
                            //based on scrolled changing view size..
                                .offset(x: index - scrolled <= 2 ? CGFloat(index - scrolled) * 30 : 60)
                            if flip == false {
                                //indexCard = deckCore.cardsArray.count
                                
                                    ZStack {
                                        
                                        Text(likedArrPersistent[index].unwrappedWord)
                                            .font(.custom("Chalkduster", size: 40))

                                            .foregroundColor(.white)
                                    }

                                    
                                    
                                    
                                } else {
                                    ZStack {
                                        
                                        Text(likedArrPersistent[index].unwrappedDefinition)
                                            .font(.custom("Chalkduster", size: 40))

                                            .foregroundColor(.white)
                                    }

                                    
                                    
                                    
                                }
                        }
                        .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
                        .padding()
                        //Spacer(minLength: 0)
                    }
                    .onAppear(perform: {
                        scrolled = 0
                        likedArrPersistent[index].offset = 0.0
                    })
                    .contentShape(Rectangle())
                    .offset(x:CGFloat(likedArrPersistent[index].offset))
                    .gesture(DragGesture().onChanged({ value in
                        withAnimation{
                            if value.translation.width < 0 && index+1 != likedArrPersistent.count {
                                likedArrPersistent[index].offset = Float(value.translation.width)

                            } else {
                                //restoring the cards..
                                if index > 0 {
                                    likedArrPersistent[index-1].offset = Float(-(calculateWidth() + 60) + value.translation.width)
                                }
                            }
                        }
                    }).onEnded({ value in
                        withAnimation{
                            if value.translation.width < 0 {
                                if -value.translation.width > 180 && index+1 != likedArrPersistent.count {
                                    //moving away..
                                    likedArrPersistent[index].offset = Float(-(calculateWidth() + 60))
                                    scrolled += 1
                                } else {
                                    likedArrPersistent[index].offset = 0.0
                                }
                            } else {
                                if index > 0 {
                                    if value.translation.width > 180 {
                                        likedArrPersistent[index-1].offset = 0.0
                                        scrolled -= 1
                                    } else {
                                        likedArrPersistent[index-1].offset = Float(-(calculateWidth() + 60))
                                    }
                                }
                            }
                        }
                    }))
                    
                  
                    Button {
                            deleteCard(at: IndexSet.init(integer: index))
                    } label: {
                        Image(systemName: "trash")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x:-110,y:-175)
                    
                }
            }
            .frame(height: 400)
            .padding(.horizontal, 25)
            .padding(.top, 1)
            .buttonStyle(PlainButtonStyle())
            
            
            Text("\(scrolled+1) of \(likedArrPersistent.count)")
                .font(.title2)
                .padding(.top, 5)
            
        

            Spacer()
        }
        //.padding(.top, 1)
        .ignoresSafeArea(.all, edges: .all)

        
       
    }
    //Use with tap gesture or delete button
    private func deleteCard(at offsets: IndexSet) {
        withAnimation {
//            offsets.map {decksArrPersistent[$0]}.forEach(viewContext.delete)
            for index in offsets {
                let deck = likedArrPersistent[index]
                
                viewContext.delete(deck)
                PersistenceController.shared.saveContext()
                //indexCard = 0
            }
        }
    }
    func calculateWidth() -> CGFloat {
        let screen =  330.0
        
        let width = screen - (2*30)
        
        return CGFloat(width)
    }
}

struct LikedCardView_Previews: PreviewProvider {
    static var previews: some View {
        LikedCardView()
    }
}
