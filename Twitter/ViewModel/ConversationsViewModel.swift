//
//  ConversationsViewModel.swift
//  Twitter
//
//  Created by Dan Hozan on 16.03.2024.
//

import SwiftUI

class ConversationsViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    private var recentMessagesDictionary = [String: Message]()
    
    init() {
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages")
        query.order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges else { return }
            
            changes.forEach { change in
                let dictionaryMessage = change.document.data()
                let uid = change.document.documentID
                
                COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
                    guard let dictionaryUser = snapshot?.data() else { return }
                    let user = User(dictionary: dictionaryUser)
                    
                    self.recentMessagesDictionary[uid] = Message(user: user, dictionary: dictionaryMessage)

                    self.recentMessages = Array(self.recentMessagesDictionary.values)
                }
            }
        }
        
    }
    
}
