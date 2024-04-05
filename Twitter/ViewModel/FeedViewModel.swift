//
//  FeedViewModel.swift
//  Twitter
//
//  Created by Dan Hozan on 15.03.2024.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        COLLECTION_TWEETS.order(by: "timestamp", descending: true).getDocuments { snapshot, _ in
            guard let dictionaries = snapshot?.documents else { return }
            self.tweets = dictionaries.map({ Tweet(dictionary: $0.data()) })
        }
    }
    
  
}
