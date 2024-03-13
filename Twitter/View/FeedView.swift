//
//  FeedView.swift
//  Twitter
//
//  Created by Dan Hozan on 07.03.2024.
//

import SwiftUI

struct FeedView: View {
    @State var isShowingNewTweetView = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack{
                    ForEach(0..<100) { _ in
                        TweetCell()
                    }
                }
                
            }
            Button(action: {
                isShowingNewTweetView.toggle()
            }, label: {
                Image("tweet")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $isShowingNewTweetView) {
                NewTweetView(isPresented: $isShowingNewTweetView)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
