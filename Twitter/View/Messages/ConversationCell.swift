//
//  ConversationCell.swift
//  Twitter
//
//  Created by Dan Hozan on 08.03.2024.
//

import SwiftUI

struct ConversationCell: View {
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image("venom")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .cornerRadius(28)
                VStack(alignment:.leading, spacing: 4){
                    Text("venom")
                        .font(.system(size: 14, weight: .semibold))
                    Text("Longer meesage text to see what happens / Longer meesage text to see what happens")
                        .font(.system(size: 15))
                        .lineLimit(2)
                    
                }
                .foregroundColor(.black)
                .padding(.trailing)
            }
            Divider()
        }
    }
}

struct ConversationCell_Previews: PreviewProvider {
    static var previews: some View {
        ConversationCell()
    }
}
