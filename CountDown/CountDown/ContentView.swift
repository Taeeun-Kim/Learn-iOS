//
//  ContentView.swift
//  CountDown
//
//  Created by Taeeun Kim on 11.06.21.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var counterVM: CounterViewModel
    
    init() {
        counterVM = CounterViewModel()
    }
    
    var body: some View {
        VStack {
            
            Text(counterVM.premium ? "Premium" : "")
                .foregroundColor(.green)
                .frame(width: 200, height: 100)
                .font(.largeTitle)
            
            Text("\(counterVM.value)")
                .font(.largeTitle)
            Button("Increment") {
                self.counterVM.increment()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
