//
//  ContentView.swift
//  URLImageDemo
//
//  Created by Taeeun Kim on 14.06.21.
//

import SwiftUI

struct ContentView: View {
    
    let posters = ["https://picsum.photos/200/300", "https://picsum.photos/200/400", "https://picsum.photos/201/300", "https://picsum.photos/202/300", "https://picsum.photos/203/300"]
    
    var body: some View {
        List(self.posters, id: \.self) { poster in
            URLImage(url: poster)
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
