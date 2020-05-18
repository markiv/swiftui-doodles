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
                NavigationLink("Clock", destination: Clock())
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
