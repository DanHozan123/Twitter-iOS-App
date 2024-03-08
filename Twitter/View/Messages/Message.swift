//
//  Message.swift
//  Twitter
//
//  Created by Dan Hozan on 08.03.2024.
//

import Foundation

struct MockMessage: Identifiable {
    let id: Int
    let imageName: String
    let messageText: String
    let isCurrentUser: Bool
}

let MOCK_MESSAGES: [MockMessage] = [
    .init(id: 0, imageName: "spiderman", messageText: "Hey what's up?", isCurrentUser: false),
    .init(id: 1, imageName: "batman", messageText: "Not much, you?", isCurrentUser: true),
    .init(id: 2, imageName: "batman", messageText: "How's the marvel uniers?", isCurrentUser: true),
    .init(id: 3, imageName: "spiderman", messageText: "hai pa", isCurrentUser: false)]
