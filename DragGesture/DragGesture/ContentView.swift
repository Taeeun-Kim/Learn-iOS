//
//  ContentView.swift
//  DragGesture
//
//  Created by Taeeun Kim on 30.04.21.
//

import SwiftUI

struct DragGestureExample2: View {
    
    let topOffset: CGFloat = 80
    
    var body: some View {
        ZStack {
            Text("Hello World")
            Rectangle()
                .fill(Color.blue)
                .cornerRadius(30)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct DragGestureExample1: View {
    @State private var dragOffset: CGSize = .zero
    @State private var postion: CGSize = .zero
    var body: some View {
        Circle()
            .fill(Color.yellow)
            .shadow(radius: 20)
            .frame(width: 100)
            .offset(x: dragOffset.width + postion.width, y: dragOffset.height + postion.height)
            .gesture(DragGesture()
                        .onChanged({ value in
                            self.dragOffset = value.translation
                        })
                        .onEnded({ value in
                            self.postion.width += value.translation.width
                            self.postion.height += value.translation.height
                            self.dragOffset = .zero
                        })
            )
    }
}

struct ContentView: View {
    var body: some View {
        DragGestureExample2()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
