//
//  SearchView.swift
//  Twitter
//
//  Created by Dan Hozan on 07.03.2024.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @ObservedObject var viewModel = SearchViewModel(cofing: .search)
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                    NavigationLink(
                        destination: LazyView(UserProfileView(user: user)),
                        label: {
                            UserCell(user: user)
                        })
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

