//
//  PreviewWithState.swift
//  Doodles
//
//  Created by Vikram Kriplaney on 25.05.20.
//  Copyright © 2020 iPhonso GmbH. All rights reserved.
//

import SwiftUI

#if DEBUG
/// Allows us to conveniently pass some state to previews.
///
///     PreviewWithState(value: "Vikram") {
///         TextField(title: "First Name", text: $0)
///     }
public struct PreviewWithState<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    public var body: some View {
        content($value)
    }

    public init(value: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
#endif
