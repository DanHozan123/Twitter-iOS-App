//
//  ChatBubble.swift
//  Twitter
//
//  Created by Dan Hozan on 08.03.2024.
//

import SwiftUI

import SwiftUI

struct ChatBubble: Shape {
    var isFromCurrentUser: Bool

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, isFromCurrentUser ? .bottomLeft: .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(isFromCurrentUser: false)
    }
}
