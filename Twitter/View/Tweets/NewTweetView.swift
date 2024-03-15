//
//  NewTweetView.swift
//  Twitter
//
//  Created by Dan Hozan on 13.03.2024.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    
    @Binding var isPresented: Bool
    @State var captionText: String = ""
    @ObservedObject var viewModel: UploadTweetVewModel
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.viewModel = UploadTweetVewModel(isPresented: isPresented)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    if let user = AuthViewModel.shared.user {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 64, height: 64)
                            .cornerRadius(32)
                    }
                    
                    TextArea("What's happening?", text: $captionText)
                    
                    Spacer()
                    
                }
                .padding()
                .navigationBarItems(
                    leading: Button(action: { isPresented.toggle() }, label: { Text("Cancel") .foregroundColor(.blue) }),
                    trailing: Button(action: {
                        viewModel.uploadTweet(caption: captionText)
                        },
                                     label: {
                                         Text("Tweet")
                                             .padding(.horizontal)
                                             .padding(.vertical, 8)
                                             .background(Color.blue)
                                             .foregroundColor(.white)
                                             .clipShape(Capsule())
                                     }))
                Spacer()
            }
        }
        
    }
    
}
