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
    @ObservedObject var viewModel = SearchViewModel()

    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            VStack() {
                ForEach(viewModel.users) { user in
                    
                    Button(action: {
                        self.show.toggle()
                        self.startChat.toggle()
                    }, label: {
                        UserCell(user: user)
                        
                    })
                }
            }
        }

    }
    
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(show: .constant(true), startChat: .constant(true))
    }
}
