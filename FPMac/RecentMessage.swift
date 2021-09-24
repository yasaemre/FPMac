//
//  RecentMessage.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/22/21.
//

import SwiftUI

struct RecentMessage:Identifiable {
    var id = UUID().uuidString
    var lastMsg: String
    var lastMsgTime: String
    var pendingMsgs: String
    var userName: String
    var userImage: String
    var allMsgs: [Message]
}

var recentMsgs: [RecentMessage] = [

    RecentMessage(lastMsg: "Apple Tech", lastMsgTime: "15:00", pendingMsgs: "9", userName: "Selvi", userImage: "p0", allMsgs: Eachmsg.shuffled()),
    RecentMessage(lastMsg: "Apple Tech sdf ", lastMsgTime: "15:00", pendingMsgs: "9", userName: "Theo", userImage: "p1", allMsgs: Eachmsg.shuffled()),
    RecentMessage(lastMsg: "Apple Tech", lastMsgTime: "14:40", pendingMsgs: "9", userName: "Huriye", userImage: "p2", allMsgs: Eachmsg.shuffled()),
    RecentMessage(lastMsg: "Apple Tech", lastMsgTime: "1:00", pendingMsgs: "9", userName: "Luna", userImage: "p3", allMsgs: Eachmsg.shuffled()),
    RecentMessage(lastMsg: "Apple Tech", lastMsgTime: "15:00", pendingMsgs: "9", userName: "Eva", userImage: "p4", allMsgs: Eachmsg.shuffled()),
    RecentMessage(lastMsg: "Apple Tech", lastMsgTime: "15:00", pendingMsgs: "9", userName: "Jane", userImage: "p5", allMsgs: Eachmsg.shuffled()),
    RecentMessage(lastMsg: "Apple Tech", lastMsgTime: "15:00", pendingMsgs: "9", userName: "Emre", userImage: "p6", allMsgs: Eachmsg.shuffled()),

]
