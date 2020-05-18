//
//  Clock.swift
//  Doodles
//
//  Created by Vikram Kriplaney on 18.05.20.
//  Copyright © 2020 iPhonso GmbH. All rights reserved.
//

import SwiftUI

struct Needle: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            $0.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            $0.closeSubpath()
        }
    }
}

struct Clock: View {
    @State private var hour = 10
    @State private var minute = 9
    @State private var second = 30
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

    var body: some View {
        ZStack(alignment: .center) {
            Circle().stroke(Color.secondary).frame(width: 200)
            Group {
                Circle().frame(width: 8)
                Needle()
                    .frame(width: 5, height: 60)
                    .offset(y: -30)
                    .rotationEffect(.degrees(Double(hour * 30)))
                Needle()
                    .frame(width: 5, height: 100)
                    .offset(y: -50)
                    .rotationEffect(.degrees(Double(minute * 6)))
                Needle()
                    .foregroundColor(.red)
                    .frame(width: 1, height: 100)
                    .offset(y: -50)
                    .rotationEffect(.degrees(Double(second * 6)))
                Circle().frame(width: 5).foregroundColor(.red)
            }
            .shadow(radius: 1, y: 3)
        }
        .onReceive(timer) { _ in
            let components = Calendar.autoupdatingCurrent
                .dateComponents([.hour, .minute, .second], from: Date())
            self.hour = components.hour!
            self.minute = components.minute!
            self.second = components.second!
        }
//        .frame(width: 200, height: 200)
        .animation(.spring(response: 0.2, dampingFraction: 0.3))
    }
}

#if DEBUG
    struct Clock_Previews: PreviewProvider {
        static var previews: some View {
            Clock()
        }
    }
#endif
