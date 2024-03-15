//
//  UserCell.swift
//  Twitter
//
//  Created by Dan Hozan on 08.03.2024.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack() {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 56, height: 56)
                .cornerRadius(28)
                .padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(user.username)
                    .font(.system(size: 14, weight: .semibold))
                
                Text(user.fullname)
                    .font(.system(size: 14))
            }
            .foregroundColor(.black)
            
            Spacer()
        }
    }
}
