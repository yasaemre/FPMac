//
//  Message.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/22/21.
//

import SwiftUI

struct Message: Identifiable, Equatable{
    var id = UUID().uuidString
    var message: String
    var myMessage: Bool
}

var Eachmsg = [
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false),
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false),
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false),
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false),
    Message(message: "dfgs dfgfd gdf gdf gfd df gdf ", myMessage: false),
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false),
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false),
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false)
]

