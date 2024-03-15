//
//  UserProfileView.swift
//  Twitter
//
//  Created by Dan Hozan on 13.03.2024.
//

import SwiftUI

struct UserProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    var user: User
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(isFollowed: $viewModel.isFollowed, viewModel: viewModel)
                    .padding()
                
                ForEach(0..<9) { tweet in
                    //TweetCell().padding()
                }
            }
            .navigationTitle("Batman")
        }
    }
}
