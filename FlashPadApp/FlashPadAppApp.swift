//
//  FPMacApp.swift
//  FPMac
//
//  Created by Emre Yasa on 9/24/21.
//

import SwiftUI

@main
struct FlashPadAppApp: App {

    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    @StateObject var deckList = DeckList()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(deckList)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }

    }
}


extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get{.none}
        set { }
    }
}

