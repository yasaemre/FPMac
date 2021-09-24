//
//  ProfileView.swift
//  FPMac
//
//  Created by Emre Yasa on 9/24/21.
//


import SwiftUI

struct ProfileView: View {
    
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

    var body: some View {

        VStack(spacing: 30) {
            Spacer()
            Group {
                HStack(spacing:10) {
                    Text("Name: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)
                    VStack {
                        if let name =  profileArrPersistent.last?.name {
                        TextField(" \(name)", text: $name)
                            .font(Font.system(size: 25, design: .default))
                        } else {
                            TextField("Name", text: $name)
                                .font(Font.system(size: 25, design: .default))
                        }
                        
                        
                    }
                }
                
                
                
                
                HStack(spacing:10) {
                    Text("Last Name: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)
                    VStack {
                        if let lname =  profileArrPersistent.last?.lastName {
                        TextField("\(lname)", text: $lastName)
                            .font(Font.system(size: 25, design: .default))
                        } else {
                            TextField("Last Name", text: $lastName)
                                .font(Font.system(size: 25, design: .default))
                        }
                        
                        
                    }

                }
                
                
                HStack(spacing:10){
                    Text("Age: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)
                    VStack {
                        if let age =  profileArrPersistent.last?.age {
                        TextField("\(age)", text: $age)
                            .font(Font.system(size: 25, design: .default))
                            .textContentType(.oneTimeCode)
                            
                        } else {
                            TextField("Age", text: $age)
                                .font(Font.system(size: 25, design: .default))
                                .textContentType(.oneTimeCode)
                        }
                      
                        
                    }

                }
                

                HStack(spacing:10) {
                    Text("Sex: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)
                    VStack {
                        if let sex =  profileArrPersistent.last?.sex {
                        TextField("\(sex)", text: $sex)
                            .font(Font.system(size: 25, design: .default))
                        } else {
                            TextField("Sex", text: $sex)
                                .font(Font.system(size: 25, design: .default))
                        }
                       
                        
                    }
                }
                

                HStack(spacing:10) {
                    Text("Location: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)

                    VStack {
                        if let loc =  profileArrPersistent.last?.location {
                        TextField("\(loc)", text: $location)
                            .font(Font.system(size: 25, design: .default))
                        } else {
                            TextField("Location", text: $location)
                                .font(Font.system(size: 25, design: .default))
                        }
                       
                        
                    }
                }
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            
            HStack {
                Spacer()
                
                Button {
                    let profileCore = ProfileCore(context:viewContext)
        
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
                    
                } label: {
                    Text("Save")
                        .font(.title)
                        .frame(width: 130, height: 50)
                        .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "1130C1"), Color.init(hex: "c8d4f5")]),  center: .center, startRadius: 5, endRadius: 120))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                }
                .padding(.trailing, 20)
                .buttonStyle(PlainButtonStyle())

            }
            
            Spacer()
        
        }


    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}


//extension UIImage {
//    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
//    var png: Data? { pngData() }
//}
