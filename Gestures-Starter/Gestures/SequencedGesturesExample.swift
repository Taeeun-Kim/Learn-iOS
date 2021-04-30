//
//  SequencedGesturesExample.swift
//  Gestures
//
//  Created by Taeeun Kim on 30.04.21.
//  Copyright © 2021 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct SequencedGesturesExample: View {
    
    @State private var isScaled = false
    @State private var postion = CGSize.zero
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 0.5)
            .onEnded { _ in
                isScaled = true
            }
        
        let dragGesture = DragGesture()
            .onChanged { value in
                dragOffset = value.translation
                isScaled = true
            }
            .onEnded { value in
                postion.width += value.translation.width
                postion.height += value.translation.height
                dragOffset = .zero
                isScaled = false
            }
            
        let longPressBeforeDragGesture = longPressGesture.sequenced(before: dragGesture)
        
        
        return Circle()
            .fill(Color.red)
            .shadow(radius: 20)
            .frame(width: 100)
            .scaleEffect(isScaled ? 1.5 : 1)
            .offset(x: postion.width + dragOffset.width, y: postion.height + dragOffset.height)
            .animation(.easeInOut(duration: 0.5))
            .gesture(longPressBeforeDragGesture)
    }
}

struct SequencedGesturesExample_Previews: PreviewProvider {
    static var previews: some View {
        SequencedGesturesExample()
    }
}
