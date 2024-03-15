//
//  ContentView.swift
//  Twitter
//
//  Created by Dan Hozan on 07.03.2024.
//

import SwiftUI

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
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        else {
            LoginView()
        }
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
