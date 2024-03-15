//
//  AuthViewModel.swift
//  Twitter
//
//  Created by Dan Hozan on 14.03.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class AuthViewModel: ObservableObject {
    @Published var userSession: Firebase.User?
    @Published var isAuthentification = false
    @Published var error: Error?
    //@Published var user: User?
    
    init () {
        userSession = Auth.auth().currentUser
        fetchUser()
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result , error  in
            if let error = error {
                print("ERROR: ", error.localizedDescription)
            }
            self.userSession = result?.user
        }
    }
    
    func register(email: String, password: String, fullname: String, username: String, profileImage: UIImage) {
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("ERROR: ", error.localizedDescription)
                return
            }
            
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("ERROR: ", error.localizedDescription)
                        return
                    }
                    guard let user = result?.user else { return }
                    
                    let data = ["email": email,
                                "username": username.lowercased(),
                                "fullname": fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": user.uid]
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                        if let error = error {
                            print("ERROR: ", error.localizedDescription)
                        }
                        self.userSession = user
                    }
                }
            }
        }
    }
    
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            let user = User(dictionary: data)
            print(user)
        }
    }
}
