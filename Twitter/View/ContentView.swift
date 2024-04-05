//
//  ContentView.swift
//  Twitter
//
//  Created by Dan Hozan on 07.03.2024.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        
        if viewModel.userSession != nil {
            NavigationView {
                TabView {
                    FeedView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("home")
                        }
                    
                    SearchView()
                       
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    
                    ConversationsView()
                    
                        .tabItem {
                            Image(systemName: "envelope")
                            Text("envelope")
                        }
                }
                .navigationBarTitle("home")
                .navigationBarItems(leading: Button(action: { viewModel.signOut() }, label: {
                    if let user = viewModel.user {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 32, height: 32)
                            .cornerRadius(16)
                    }
                }))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        else {
            LoginView()
        }
        
        
        
        
    }
}
