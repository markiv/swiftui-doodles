//
//  FloatingTextField.swift
//  Doodles
//
//  Created by Vikram Kriplaney on 25.05.20.
//  Copyright © 2020 iPhonso GmbH. All rights reserved.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let text: Binding<String>

    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .foregroundColor(text.wrappedValue.isEmpty ? Color(.placeholderText) : .accentColor)
                .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.75, anchor: .leading)
            TextField("", text: text)
        }
        .padding(.top, 15)
        .animation(.spring(response: 0.4, dampingFraction: 0.3))
    }
}

struct FloatingTextFieldDemo: View {
    @State private var firsName = "Vikram"
    @State private var lastName = "Kriplaney"
    @State private var address = ""
    @State private var twitter = "@krips"

    var body: some View {
        List {            
            FloatingTextField(title: "First Name", text: $firsName)
            FloatingTextField(title: "Last Name", text: $lastName)
            FloatingTextField(title: "Address", text: $address)
            FloatingTextField(title: "Twitter", text: $twitter)
        }.navigationBarTitle("Floating Text Field")
    }
}

#if DEBUG
    struct FloatingTextField_Previews: PreviewProvider {
        static var previews: some View {
            FloatingTextFieldDemo()
        }
    }
#endif
