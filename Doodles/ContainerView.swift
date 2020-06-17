//
//  Container.swift
//  Home
//
//  Created by Vikram Kriplaney on 22.04.20.
//  Copyright © 2020 Netcetera AG. All rights reserved.
//

import SwiftUI

/// The `ContainerView` protocol and its default initializers help to create and set up custom container views
/// without any unnecessary boilerplate code.
/// `ContainerView` provides initializers for 1 to 10 child views and also supports dynamically computed child
/// views inside a `ForEach`.
///
/// All a conforming view type needs to do is implement its `body`. For example:
///
///     struct Card: ContainerView {
///         var items: [AnyView] = []
///
///         var body: some View {
///             VStack {
///                 ForEach(0..<items.count) { index in
///                     self.items[index].background(Color.gray).padding()
///                 }
///             }
///         }
///     }
///
/// Your  new container type can then simply be used like this:
///
///     Card {
///         Text("Hello")
///         Text("World!")
///     }
///
/// Or like this:
///
///     Card {
///         ForEach(1..<10) {
///             Text("Index \($0)")
///         }
///     }
///     Card {
///         ForEach(["John", "Paul", "George", "Ringo"], id: \.self) {
///             Text("Hello \($0)!")
///         }
///     }
protocol ContainerView: View {
    var items: [AnyView] { get set }
    init()
}

extension ContainerView {
    /// Creates a container with a single child view in it.
    public init<A: View>(@ViewBuilder content: () -> A) {
        self.init()
        let view = content()
        self.items = [AnyView(view)]
    }

    /// Creates a container with two child views in it.
    public init<A: View, B: View>(
        @ViewBuilder content: () -> TupleView<(A, B)>
    ) {
        self.init()
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1)]
    }

    /// Creates a container with three child views in it.
    public init<A: View, B: View, C: View>(
        @ViewBuilder content: () -> TupleView<(A, B, C)>
    ) {
        self.init()
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2)]
    }

    /// Creates a container with four child views in it.
    public init<A: View, B: View, C: View, D: View>(
        @ViewBuilder content: () -> TupleView<(A, B, C, D)>
    ) {
        self.init()
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2), AnyView(views.3)]
    }

    /// Creates a container with five child views in it.
    public init<A: View, B: View, C: View, D: View, E: View>(
        @ViewBuilder content: () -> TupleView<(A, B, C, D, E)>
    ) {
        self.init()
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2),
                      AnyView(views.3), AnyView(views.4)]
    }

    /// Creates a container with six child views in it.
    public init<A: View, B: View, C: View, D: View, E: View, F: View>(
        @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F)>
    ) {
        self.init()
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2),
                      AnyView(views.3), AnyView(views.4), AnyView(views.5)]
    }

    /// Creates a container with seven child views in it.
    public init<A: View, B: View, C: View, D: View, E: View, F: View, G: View>(
        @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F, G)>
    ) {
        self.init()
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2),
                      AnyView(views.3), AnyView(views.4), AnyView(views.5),
                      AnyView(views.6)]
    }

    /// Creates a container with eight child views in it.
    public init<A: View, B: View, C: View, D: View, E: View, F: View, G: View,
        H: View>(
        @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F, G, H)>
    ) {
        self.init()
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2),
                      AnyView(views.3), AnyView(views.4), AnyView(views.5),
                      AnyView(views.6), AnyView(views.7)]
    }

    /// Creates a container with nine child views in it.
    public init<A: View, B: View, C: View, D: View, E: View, F: View, G: View,
        H: View, I: View>(
        @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F, G, H, I)>
    ) {
        self.init()
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2),
                      AnyView(views.3), AnyView(views.4), AnyView(views.5),
                      AnyView(views.6), AnyView(views.7), AnyView(views.8)]
    }

    /// Creates a container with ten child views in it.
    public init<A: View, B: View, C: View, D: View, E: View, F: View, G: View,
        H: View, I: View, J: View>(
        @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F, G, H, I, J)>
    ) {
        self.init()
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2),
                      AnyView(views.3), AnyView(views.4), AnyView(views.5),
                      AnyView(views.6), AnyView(views.7), AnyView(views.8),
                      AnyView(views.9)]
    }

    /// Creates a container that computes its items on demand from an underlying
    /// collection of identified data.
    public init<Data, Content: View, ID: Hashable>(
        @ViewBuilder content: () -> ForEach<Data, ID, Content>
    ) {
        self.init()
        let views = content()
        self.items = views.data.map { AnyView(views.content($0)) }
    }
}

