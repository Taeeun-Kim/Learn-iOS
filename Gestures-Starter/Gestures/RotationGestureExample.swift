//
//  RotationGestureExample.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-16.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct RotationGestureExample: View {
    var body: some View {
        Rectangle()
            .fill(Color.red)
            .shadow(radius: 20)
            .frame(width: 200, height: 200)
    }
}

struct RotationGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureExample()
    }
}
