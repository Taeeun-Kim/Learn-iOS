//
//  ContentView.swift
//  WatchPrototype WatchKit Extension
//
//  Created by Taeeun Kim on 19.08.21.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image("test")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .offset(y: 12)
        }
        .frame(width: WKInterfaceDevice.current().screenBounds.width, height: WKInterfaceDevice.current().screenBounds.height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
