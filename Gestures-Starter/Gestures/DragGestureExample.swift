//
//  DragGestureExample.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-15.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct DragGestureExample: View {
    var body: some View {
        Circle()
            .fill(Color.red)
            .shadow(radius: 20)
            .frame(width: 100)
    }
}

struct DragGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureExample()
    }
}
