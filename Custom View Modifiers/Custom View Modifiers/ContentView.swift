//
//  ContentView.swift
//  Custom View Modifiers
//
//  Created by Stewart Lynch on 2020-12-27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(MyImage.images) { image in
                Image(image.name)
                    .displayImage(width: 300)
                    .overlayCaption(caption: image.caption)
                    .centerInList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
