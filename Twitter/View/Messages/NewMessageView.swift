//
//  NewMessageView.swift
//  Twitter
//
//  Created by Dan Hozan on 08.03.2024.
//

import SwiftUI

struct NewMessageView: View {
    @State var searchText = ""
    @Binding var show: Bool
    @Binding var startChat: Bool
    @Binding var user: User?
    @ObservedObject var viewModel = SearchViewModel(cofing: .newMessage)

    
    var body: some View {
        ScrollView {
            
            SearchBar(text: $searchText)
                .padding()
            
            VStack() {
                
                ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                    
                    Button(action: {
                        self.show.toggle()
                        self.startChat.toggle()
                        self.user = user
                    }, label: {
                        UserCell(user: user)
                        
                    })
                    
                }
            }
        }

    }
    
}

