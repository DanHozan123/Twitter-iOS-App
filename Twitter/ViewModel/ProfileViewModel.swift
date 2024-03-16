//
//  ProfileViewModel.swift
//  Twitter
//
//  Created by Dan Hozan on 15.03.2024.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var userTweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserTweets()
        fetchLikedTweets()
        fetchUserStats()
    }
  
    
    func tweet(forFilter filter: TweetFilterOptions) -> [Tweet] {
        switch filter {
        case .tweets: return userTweets
        case .likes: return likedTweets
        }
    }
    
}

// MARK: - API
extension ProfileViewModel {
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).setData([:]) { _ in
            COLLECTION_FOLLOWERS.document(self.user.id).collection("user-followers").document(currentUid).setData([:]) { _ in
                self.user.isFollowed = true
            }
        }
    }
    
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard !user.isCurrentUser else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).delete { _ in
            COLLECTION_FOLLOWERS.document(self.user.id).collection("user-followers").document(currentUid).delete { _ in
                self.user.isFollowed = false
            }
        }
    }
    
    func checkIfUserIsFollowed() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else { return }
            self.user.isFollowed = isFollowed
        }
    }
    
    
    func fetchUserTweets() {
        COLLECTION_TWEETS.whereField("uid", isEqualTo: user.id ).getDocuments { snapshot, _ in
            guard let dictionaries = snapshot?.documents else { return }
            self.userTweets = dictionaries.map({ Tweet(dictionary: $0.data()) })
        }
    }
    
    func fetchLikedTweets() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        var tweets = [Tweet]()
        COLLECTION_USERS.document(currentUid).collection("user-likes").getDocuments { snapshot, _ in
            guard let dictionaries = snapshot?.documents else { return }
            let tweetIDs = dictionaries.map({ $0.documentID })
            
            tweetIDs.forEach { id in
                COLLECTION_TWEETS.document(id).getDocument { snapshot, _ in
                    guard let dictionary = snapshot?.data() else { return }
                    let tweet = Tweet(dictionary: dictionary)
                    tweets.append(tweet)
                    guard tweets.count == tweetIDs.count else { return }
                    self.likedTweets = tweets
                }
            }
        }
    }
    
    func fetchUserStats() {
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        let followingRef = COLLECTION_FOLLOWING.document(user.id).collection("user-following")
        
        followersRef.getDocuments { snapshot, _ in
            guard let followersCount = snapshot?.documents.count else { return }
            followingRef.getDocuments { snapshot, _ in
                guard let followingCount = snapshot?.documents.count else { return }
                self.user.stats = UserStats(followers: followersCount, following: followingCount)
            }
        }
    }
    
}
