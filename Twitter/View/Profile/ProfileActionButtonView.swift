//
//  ProfileActionButtonView.swift
//  Twitter
//
//  Created by Dan Hozan on 13.03.2024.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        
        if viewModel.user.isCurrentUser {
            
            Button(
                action: {
                    
                },
                label: {
                    Text("Edit Profile")
                        .frame(width: 360, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                })
        }
        else {
            HStack {
                Button(
                    action: {
                        viewModel.user.isFollowed ? viewModel.unfollow() : viewModel.follow()

                    },
                    label: {
                        Text(viewModel.user.isFollowed ? "Following" : "Follow")
                            .frame(width: 180, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    })
                
                NavigationLink(destination: ChatView(user: viewModel.user), label: {
                    Text("Message")
                        .frame(width: 180, height: 40)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                })
            }
        }
    }
}

