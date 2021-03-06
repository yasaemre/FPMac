//
//  ProfileView.swift
//  FPMac
//
//  Created by Emre Yasa on 9/24/21.
//


import SwiftUI

struct ProfileView: View {
    
    @State private var image = Data()
    @State private var name = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var sex = ""
    @State private var location = ""
    @State private var isShowingPhotoPicker = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    
    @StateObject var profileCore = ProfileCore()
    @State private var index = 0
    
    @State private var rotateCheckMark = 30
    @State private var checkMarkValue = -60
    
    @State private var showCircle = 0
    
    @State private var isShowingCheckMark = false


    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 30) {
                    Spacer()
                    Group {
                        Text("Profile")
                            .font(.title)
                        HStack(spacing:geo.size.width * 0.07) {
                            Text("Name: ")
                                .font(.title)
                            VStack {
                                if let name =  profileArrPersistent.last?.name {
                                    TextField(" \(name)", text: $name)
                                        .font(Font.system(size: 25, design: .default))
                                        .frame(width: geo.size.width * 0.4)
                                } else {
                                    TextField("Name", text: $name)
                                        .font(Font.system(size: 25, design: .default))
                                        .frame(width: geo.size.width * 0.4)

                                }
                            }
                        }
                        
                        HStack(spacing:geo.size.width * 0.03) {
                            Text("Last Name: ")
                                .font(.title)
                            VStack {
                                if let lname =  profileArrPersistent.last?.lastName {
                                    TextField("\(lname)", text: $lastName)
                                        .font(Font.system(size: 25, design: .default))
                                        .frame(width: geo.size.width * 0.4)

                                } else {
                                    TextField("Last Name", text: $lastName)
                                        .font(Font.system(size: 25, design: .default))
                                        .frame(width: geo.size.width * 0.4)

                                }
                            }
                        }
                        
                        HStack(spacing:geo.size.width * 0.08){
                            Text("Age: ")
                                .font(.title)
                            VStack {
                                if let age =  profileArrPersistent.last?.age {
                                    TextField("\(age)", text: $age)
                                        .font(Font.system(size: 25, design: .default))
                                        .textContentType(.oneTimeCode)
                                        .frame(width: geo.size.width * 0.4)

                                    
                                } else {
                                    TextField("Age", text: $age)
                                        .font(Font.system(size: 25, design: .default))
                                        .textContentType(.oneTimeCode)
                                        .frame(width: geo.size.width * 0.4)

                                }
                            }
                            
                        }
                        
                        
                        HStack(spacing:geo.size.width * 0.08) {
                            Text("Sex: ")
                                .font(.title)
                            VStack {
                                if let sex =  profileArrPersistent.last?.sex {
                                    TextField("\(sex)", text: $sex)
                                        .font(Font.system(size: 25, design: .default))
                                        .frame(width: geo.size.width * 0.4)

                                } else {
                                    TextField("Sex", text: $sex)
                                        .font(Font.system(size: 25, design: .default))
                                        .frame(width: geo.size.width * 0.4)

                                }
                            }
                        }
                        HStack(spacing:geo.size.width * 0.04) {
                            Text("Location: ")
                                .font(.title)
                            
                            VStack {
                                if let loc =  profileArrPersistent.last?.location {
                                    TextField("\(loc)", text: $location)
                                        .font(Font.system(size: 25, design: .default))
                                        .frame(width: geo.size.width * 0.4)

                                } else {
                                    TextField("Location", text: $location)
                                        .font(Font.system(size: 25, design: .default))
                                        .frame(width: geo.size.width * 0.4)

                                }
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            
                            withAnimation{
                                isShowingCheckMark.toggle()
                            }
                            let profileCore = ProfileCore(context:viewContext)
                            
                            if image.isEmpty {
                                if let img = profileArrPersistent.last?.image {
                                    profileCore.image = img
                                }
                            } else {
                                profileCore.image = image
                                
                            }
                            if name.isEmpty {
                                if let name = profileArrPersistent.last?.name {
                                    profileCore.name = name
                                }
                            } else {
                                profileCore.name = name
                            }
                            if lastName.isEmpty {
                                if let lastName = profileArrPersistent.last?.lastName {
                                    profileCore.lastName = lastName
                                }
                            } else {
                                profileCore.lastName = lastName
                            }
                            if age.isEmpty {
                                if let age = profileArrPersistent.last?.age {
                                    profileCore.age = age
                                }
                            } else {
                                profileCore.age = age
                            }
                            if sex.isEmpty {
                                if let sex = profileArrPersistent.last?.sex {
                                    profileCore.sex = sex
                                }
                            } else {
                                profileCore.sex = sex
                            }
                            if location.isEmpty {
                                if let loc = profileArrPersistent.last?.location {
                                    profileCore.location = loc
                                }
                            } else {
                                profileCore.location = location
                            }
                            PersistenceController.shared.saveContext()
                            
                            showCircle = 1
                            rotateCheckMark = 0
                            checkMarkValue = 0
                            
                        } label: {
                            Text("Save")
                                .font(.title)
                                .frame(width: 130, height: 50)
                                .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "164430"), Color.init(hex: "164430")]),  center: .center, startRadius: 5, endRadius: 120))
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                                .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                        }
                        .padding(.trailing, 20)
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    Spacer()
                    
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
                        
                        VStack {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.init(hex: "067238"))
                                .font(.system(size: 60))
                                .rotationEffect(.degrees(Double(rotateCheckMark)))
                                .clipShape(Rectangle().offset(x: CGFloat(checkMarkValue)))
                                .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.75))
                                .transition(.asymmetric(insertion: .opacity, removal: .scale))
                            
                            Text("Saved")
                                .font(.title2)
                                .clipShape(Rectangle().offset(x: CGFloat(checkMarkValue)))
                                .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.75))
                                .transition(.asymmetric(insertion: .opacity, removal: .scale))
                        }
                        
                    }
                    .onAppear(perform: setDismissTimer)
                }
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
        
    }
}
