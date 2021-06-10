//
//  ContentView.swift
//  AsyncImage
//
//  Created by Taeeun Kim on 10.06.21.
//

import SwiftUI

struct ContentView: View {
    
    let airpodsMaxURL = URL(string: "https://images-na.ssl-images-amazon.com/images/I/81jqUPkIVRL._AC_SL1500_.jpg")!
    
    var body: some View {
        if #available(iOS 15.0, *) {
            AsyncImage(url: airpodsMaxURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image(systemName: "exclamationmark.circle")
                } else {
                    // being loaded
                    Image(systemName: "photo")
                }
            }
        } else {
            // Fallback on earlier versions
            Text("fqwf")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
