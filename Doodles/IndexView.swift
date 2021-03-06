//
//  IndexView.swift
//  Doodles
//
//  Created by Vikram Kriplaney on 18.05.20.
//  Copyright © 2020 iPhonso GmbH. All rights reserved.
//

import SwiftUI

struct IndexView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Clock #1", destination: LazyView(Clock()))
                NavigationLink("Clock #2", destination: LazyView(Clock2()))
                NavigationLink("Jiggle View Modifier", destination: LazyView(JiggleSample()))
                NavigationLink("Floating Text Field", destination: LazyView(FloatingTextFieldDemo()))
            }.navigationBarTitle("Doodles")
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
#endif
