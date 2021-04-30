//
//  TapGestureExample.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-15.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct TapGestureExample: View {
    @State private var isTapped = false
    
    var body: some View {
        Circle()
            .fill(Color.red)
            .shadow(radius: 20)
            .frame(width: 200)
            .scaleEffect(isTapped ? 0.5 : 1)
            .animation(.easeInOut(duration: 0.5))
            .onTapGesture {
                isTapped.toggle()
            }
    }
}

struct TapGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        TapGestureExample()
    }
}
