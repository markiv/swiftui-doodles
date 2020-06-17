//
//  Pager.swift
//  Doodles
//
//  Created by Vikram Kriplaney on 28.05.20.
//  Copyright © 2020 iPhonso GmbH. All rights reserved.
//

import SwiftUI

extension Comparable {
    func clamped(_ a: Self, _ b: Self) -> Self {
        max(min(self, a), b)
    }
}

struct Pager: ContainerView {
    let s = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    var items: [AnyView] = []
    @State var currentIndex = 0
    @GestureState private var translation: CGFloat = 0

    init() {}

    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(self.items.indices, id: \.self) { index in
                        self.items[index].frame(width: geometry.size.width)
                    }
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.$currentIndex.wrappedValue) * geometry.size.width)
                .offset(x: self.translation)
                .gesture(DragGesture()
                    .updating(self.$translation, body: { value, state, _ in
                        state = value.translation.width
                }).onEnded { value in
                        let offset = value.translation.width / geometry.size.width
                        let newIndex = Int((CGFloat(self.$currentIndex.wrappedValue) - offset).rounded())
                        print(offset, newIndex)
                        self.$currentIndex.wrappedValue = newIndex.clamped(0, self.items.count - 1)
                })
            }

            // Page indicator / control
            HStack {
                ForEach(0 ..< items.count) { index in
                    Circle().frame(width: 8)
                        .foregroundColor(index == self.$currentIndex.wrappedValue ? .primary : .secondary)
                        .onTapGesture {
                            self.$currentIndex.wrappedValue = index
                        }
                }
            }
        }.animation(.default)
    }
}

#if DEBUG
    struct Pager_Previews: PreviewProvider {
        static var previews: some View {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Pager {
                        ForEach(0 ..< 10) { index in
                            Text("Page Item \(index)")
                                .padding()
                                .frame(width: geometry.size.width - 20, height: 100)
                                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemBackground)))
                        }
                    }
                    .frame(height: 140)
                    Spacer()
                }
            }
        }
    }
#endif
