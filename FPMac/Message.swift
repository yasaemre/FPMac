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
    Message(message: "sdf sdf sdlf sdl fds ;fs dfsdl;f sdl fsdl ffkdjsf", myMessage: false),
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false),
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false),
    Message(message: "sdfljsdla;f; sd;f sd fsdfkdjsf", myMessage: false)
]

