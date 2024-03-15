//
//  UploadTweetViewModel.swift
//  Twitter
//
//  Created by Dan Hozan on 15.03.2024.
//

import SwiftUI
import Firebase

class UploadTweetVewModel: ObservableObject {
    
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    func uploadTweet(caption: String) {
        guard let user = AuthViewModel.shared.user else { return }
        let docRef = COLLECTION_TWEETS.document()
        let data: [String: Any] = [
            "uid": user.id,
            "caption": caption,
            "fullname": user.fullname,
            "timestamp": Timestamp(date: Date()),
            "username": user.username,
            "profileImageUrl": user.profileImageUrl,
            "likes": 0,
            "id": docRef.documentID]
        docRef.setData(data) {_ in
            self.isPresented = false
            
        }
        
    }
}
