//
//  RecentCardView.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/22/21.
//

import SwiftUI

struct RecentCardView: View {
    var recentMsg: RecentMessage
    //tyjytj ty tbvnvn  gng h
    var body: some View {
        HStack {
            Image(recentMsg.userImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(spacing:4) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recentMsg.userName)
                            .fontWeight(.bold)
                        Text(recentMsg.lastMsg)
                            .font(.caption)
                    }
                    
                    Spacer(minLength: 10)
                    
                    VStack {
                        Text(recentMsg.lastMsgTime)
                            .font(.caption)
                        Text(recentMsg.pendingMsgs)
                            .font(.caption2)
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

struct RecentCardView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
