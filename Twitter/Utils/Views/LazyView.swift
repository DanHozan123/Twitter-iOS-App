//
//  LazyView.swift
//  Twitter
//
//  Created by Dan Hozan on 16.03.2024.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
