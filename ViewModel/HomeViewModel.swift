//
//  HomeViewModel.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/22/21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedTab = "Home"
    
    @Published var search = ""
    
    @Published var message = ""

    @Published var isExpanded = false
    
    @Published var pickedTab = "Media"
}
