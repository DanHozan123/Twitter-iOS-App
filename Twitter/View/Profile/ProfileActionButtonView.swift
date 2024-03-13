//
//  ProfileActionButtonView.swift
//  Twitter
//
//  Created by Dan Hozan on 13.03.2024.
//

import SwiftUI

struct ProfileActionButtonView: View {
    let isCurrentUser: Bool
    var body: some View {
        
        if isCurrentUser {
            
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
                        
                    },
                    label: {
                        Text("Follow")
                            .frame(width: 180, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    })
                
                Button(
                    action: {
                        
                    },
                    label: {
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

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView(isCurrentUser: false)
    }
}
