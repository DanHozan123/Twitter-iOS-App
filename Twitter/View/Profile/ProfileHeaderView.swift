//
//  ProfileHeaderView.swift
//  Twitter
//
//  Created by Dan Hozan on 13.03.2024.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 120, height: 120)
                .cornerRadius(60)
                .shadow(radius: 10)
                
            Text(viewModel.user.fullname)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 8)
            
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Bio Description")
                .font(.system(size: 16))
                .padding(.top, 8)
            HStack (spacing: 40){
                VStack {
                    Text("\(viewModel.user.stats.followers)")
                        .font(.system(size: 16)).bold()
                    Text("Followers")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                VStack {
                    Text("\(viewModel.user.stats.following)")
                        .font(.system(size: 16)).bold()
                    Text("Following")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            ProfileActionButtonView(viewModel: viewModel)
            

            Spacer()
        }
    }
}
