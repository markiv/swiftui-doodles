//
//  ContentView.swift
//  Shake
//
//  Created by Vikram Kriplaney on 19.05.20.
//  Copyright © 2020 iPhonso GmbH. All rights reserved.
//

import SwiftUI

struct Jiggle: ViewModifier {
    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(hasAppeared ? 1 : -1))
            .offset(y: hasAppeared ? 1 : 0)
            .animation(Animation.spring().speed(5).repeatForever().delay(.random(in: 0...0.5)))
            .onAppear {
                self.hasAppeared = true
        }
    }
}

extension View {
    func jiggle() -> some View {
        self.modifier(Jiggle())
    }
}


struct Icon: View {
    @EnvironmentObject var viewModel: JiggleSample.ViewModel
    var label: String? = nil

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color(hue: .random(in: 0...1), saturation: 1, brightness: 1))
                Button(action: { self.viewModel.isShowingAlert = true }) {
                    Circle().foregroundColor(.gray).frame(width: 24, height: 24)
                        .overlay(Image(systemName: "xmark").font(.caption).foregroundColor(.white))
                        .offset(x: -8, y: -8)
                }
                .alert(isPresented: $viewModel.isShowingAlert) {
                    Alert(title: Text("Please don't delete me!"), message: Text("Please, please, please...?"))
                }
            }
            if label?.isEmpty == false {
                Text("Jiggle").font(.caption)
            }
        }
    }
}

struct JiggleSample: View {
    class ViewModel: ObservableObject {
        @Published var isShowingAlert = false
    }
    @ObservedObject var viewModel = ViewModel()

    func row(label: String? = nil) -> some View {
        HStack {
            Icon(label: label).jiggle()
            Spacer()
            Icon(label: label).jiggle()
            Spacer()
            Icon(label: label).jiggle()
            Spacer()
            Icon(label: label).jiggle()
        }
    }

    var body: some View {
        VStack {
            ForEach(1...5, id: \.self) { _ in
                self.row(label: "Jiggle")
            }.padding(.horizontal)
            Spacer()
            row().padding().background(
                RoundedRectangle(cornerRadius: 30, style: .continuous).foregroundColor(Color.secondary.opacity(0.5))
            ).padding(10)
        }
        .edgesIgnoringSafeArea(.bottom)
        .environmentObject(viewModel)
    }
}

#if DEBUG
    struct JiggleSample_Previews: PreviewProvider {
        static var previews: some View {
            JiggleSample()
        }
    }
#endif
