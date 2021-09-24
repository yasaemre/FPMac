//
//  FPMacApp.swift
//  FPMac
//
//  Created by Emre Yasa on 9/24/21.
//

import SwiftUI

@main
struct FPMacApp: App {

    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

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

