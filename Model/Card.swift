//
//  Card.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//


import Foundation
import SwiftUI


struct Card: Identifiable{
     var word:String = ""
     var definition:String = ""
     var id = UUID()
    /// Card x position
     var x: CGFloat = 0.0
        /// Card y position
     var y: CGFloat = 0.0
    var offset: CGFloat = 0.0
        /// Card rotation angle
     var degree: Double = 0.0
    var imageName = "bbS"

}
