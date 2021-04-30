//
//  DragGestureExample.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-15.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct DragGestureExample: View {
    @State private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    var body: some View {
        
        Circle()
            .fill(Color.yellow)
            .shadow(radius: 20)
            .frame(width: 100)
            .offset(x: dragOffset.width + position.width, y: dragOffset.height + position.height)
            .gesture(DragGesture()
                        .onChanged({ value in
                            self.dragOffset = value.translation
                        })
                        .onEnded({ value in
                            self.position.width += value.translation.width
                            self.position.height += value.translation.height
                            self.dragOffset = .zero
                        })
            )
    }
}

struct DragGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureExample()
    }
}
