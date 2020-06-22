//
//  Clock2.swift
//  Doodles
//
//  Created by Vikram Kriplaney on 18.05.20.
//  Copyright © 2020 iPhonso GmbH. All rights reserved.
//

import SwiftUI

struct Clock2: View {
    @State private var hour = 10.0
    @State private var minute = 9
    @State private var second = 30
    @State private var isFirstTime = true

    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

    var body: some View {
        ZStack(alignment: .center) {
            Face()
            Group {
                // The hour hand
                Rectangle()
                    .frame(width: 10, height: 80)
                    .offset(y: -20)
                    .rotationEffect(.degrees(hour * 30.0))
                // The minute hand
                Rectangle()
                    .frame(width: 8, height: 110)
                    .offset(y: -40)
                    .rotationEffect(.degrees(Double(minute * 6)))
                // The seconds hand, with a circle at the end
                SecondsHand()
                    .rotationEffect(.degrees(Double(second * 6)))
            }.shadow(radius: 1, y: 3)
        }.onReceive(timer) { _ in self.updateTime() }
    }

    /// The notches of our famous clock face
    struct Face: View {
        var body: some View {
            ForEach(0...59, id: \.self) { index in
                Group {
                    if index.isMultiple(of: 5) {
                        Rectangle().frame(width: 6, height: 20).offset(y: -90)
                    } else {
                        Rectangle().frame(width: 2, height: 10).offset(y: -95)
                    }
                }.rotationEffect(.degrees(Double(index * 6)))
            }
        }
    }

    /// The seconds hand, with a circle at the end
    struct SecondsHand: View {
        var body: some View {
            Rectangle()
                .foregroundColor(.red)
                .overlay(Circle().foregroundColor(.red).frame(width: 20).offset(y: -40))
                .frame(width: 3, height: 100)
                .offset(y: -30)
        }
    }

    func updateTime() {
        let components = Calendar.autoupdatingCurrent
            .dateComponents([.hour, .minute, .second], from: Date())
        let minute = components.minute! + 60 * components.hour!
        let second60 = components.second!
        let second = second60 + 60 * minute

        // Hold at zero seconds, like the famous clock
        if isFirstTime || second60 != 1 {
            withAnimation(isFirstTime ? .none : .linear(duration: 1)) {
                self.second = second
            }
        }
        withAnimation(isFirstTime ? .none : .spring(response: 0.2, dampingFraction: 0.4)) {
            hour = Double(components.hour!) + Double(components.minute!) / 60
            if isFirstTime || second60 > 1 {
                self.minute = minute
            }
        }
        isFirstTime = false
    }
}

#if DEBUG
    struct Clock2_Previews: PreviewProvider {
        static var previews: some View {
            Clock2()
        }
    }
#endif
