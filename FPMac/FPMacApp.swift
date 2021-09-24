//
//  FPMacApp.swift
//  FPMac
//
//  Created by Emre Yasa on 9/24/21.
//

import SwiftUI

@main
struct FlashPadMacOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get{.none}
        set { }
    }
}
