//
//  ChatViewModel.swift
//  Twitter
//
//  Created by Dan Hozan on 16.03.2024.
//

import SwiftUI
import Firebase

class ChatViewModel: ObservableObject {
    
    let user: User
    @Published var messages = [Message]()
    
    init(user: User) {
        self.user = user
        fetchMesseges()
    }
    
    func fetchMesseges() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection(user.id)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            
            changes.forEach { change in
                let dictionaryMessage = change.document.data()
                guard let fromId = dictionaryMessage["fromId"] as? String else { return }
                
                COLLECTION_USERS.document(fromId).getDocument { snapshot, _ in
                    guard let dictionaryUser = snapshot?.data() else { return }
                    let user = User(dictionary: dictionaryUser)
                    self.messages.append(Message(user: user, dictionary: dictionaryMessage))
                    self.messages.sort(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
                  
                }
            }
        }
        
    }
    
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
       
        let currentUserRef = COLLECTION_MESSAGES.document(currentUid).collection(user.id).document()
        let messageID = currentUserRef.documentID
        let receivingUserRef = COLLECTION_MESSAGES.document(user.id).collection(currentUid).document(messageID)
        
        let receivingRecentRef = COLLECTION_MESSAGES.document(user.id).collection("recent-messages")
        let currentRecentRef = COLLECTION_MESSAGES.document(currentUid).collection("recent-messages")

        let data : [String: Any] = ["text": messageText,
                    "id": messageID,
                    "fromId": currentUid,
                    "toId": user.id,
                    "timestamp": Timestamp(date: Date())]
        currentUserRef.setData(data)
        receivingUserRef.setData(data)
            
        receivingRecentRef.document(currentUid).setData(data)
        currentRecentRef.document(user.id).setData(data)
        
    }
}
