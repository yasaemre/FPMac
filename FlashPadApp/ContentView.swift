//
//  ContentView.swift
//  FPMac
//
//  Created by Emre Yasa on 9/24/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        Home().toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: { // 1
                    Image(systemName: "sidebar.leading")
                })
            }
        }
    }
    private func toggleSidebar() { // 2
          NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
      }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
