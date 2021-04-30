//
//  LongPressGestureExample.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-15.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct LongPressGesture: View {
    @State private var isLongPressed = false
    var body: some View {
        Circle()
            .fill(Color.red)
            .shadow(radius: 20)
            .frame(width: 200)
            .scaleEffect(isLongPressed ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 0.5))
    }
}

struct LongPressGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGesture()
    }
}
