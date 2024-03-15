//
//  SearchViewModel.swift
//  Twitter
//
//  Created by Dan Hozan on 15.03.2024.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var users =  [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, error in
            if let error = error {
                print("ERROR: ", error.localizedDescription)
            }
            guard let dictionaries = snapshot?.documents else { return }
            self.users = dictionaries.map({ User(dictionary: $0.data()) })
        }
    }
    
}
