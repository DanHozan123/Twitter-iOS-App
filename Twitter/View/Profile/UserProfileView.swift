//
//  UserProfileView.swift
//  Twitter
//
//  Created by Dan Hozan on 13.03.2024.
//

import SwiftUI

struct UserProfileView: View {
    @State var selectedFilter: TweetFilterOptions = .tweets
    @ObservedObject var viewModel: ProfileViewModel
    
    var user: User
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(viewModel: viewModel)
                    .padding()
                
                FilterButtonView(selectedOption: $selectedFilter)
                
                ForEach(viewModel.tweet(forFilter: selectedFilter)) { tweet in
                    TweetCell(tweet: tweet)
                        .padding(.leading, 25)
                }
            }
            .navigationTitle("Batman")
        }
    }
}
