//
//  LazyView.swift
//  Doodles
//
//  Created by Vikram Kriplaney on 18.05.20.
//  Copyright © 2020 iPhonso GmbH. All rights reserved.
//

import SwiftUI

/// A wrapper that delays its enclosed view's construction. Especially useful in `NavigationLink`s whose
/// destination views you don't want to construct before they're presented:
///
///     NavigationLink(destination: LazyView(SomeView()), label: { Text("Link") })
struct LazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
