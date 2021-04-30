//
//  ContentView.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-15.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("""
If you want to run one of
the swift files in your simulator,
go to SceneDelegate.swift and change
let contentView = ContentView()
to
let contentView = NewView()
Where "NewView" is the name of the view
you want to work with.
""")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
