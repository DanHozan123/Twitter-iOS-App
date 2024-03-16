//
//  SearchViewModel.swift
//  Twitter
//
//  Created by Dan Hozan on 15.03.2024.
//

import SwiftUI
import Firebase

enum SearchvewModelConfiguration {
    case search
    case newMessage
}

class SearchViewModel: ObservableObject {
    @Published var users =  [User]()
    private let config: SearchvewModelConfiguration
    
    init(cofing: SearchvewModelConfiguration) {
        self.config = cofing
        fetchUsers(config: config)
    }
    
    
    
    func fetchUsers(config: SearchvewModelConfiguration) {
        
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let dictionaries = snapshot?.documents else { return }
            let users =  dictionaries.map({ User(dictionary: $0.data()) })
            switch config {
            case .newMessage:
                self.users =  users.filter({ !$0.isCurrentUser })
            case.search:
                self.users = users
                
            }
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.contains(lowercasedQuery) })
    }
    
    
}
