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
    @State private var isTapped3 = false
    
    var body: some View {
        Circle()
            .fill(isTapped3 ? Color.green : Color.red)
            .shadow(radius: 20)
            .frame(width: 200)
            .scaleEffect(isTapped ? 0.8 : 1.6)
            .animation(.easeInOut(duration: 0.5))
            .gesture(TapGesture(count: 2)
                        .onEnded {
                            self.isTapped.toggle()
                        }
                        .simultaneously(with: TapGesture(count: 3)
                                            .onEnded {
                                                self.isTapped3.toggle()
                                            }
                        )

            )
    }
}

struct TapGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        TapGestureExample()
    }
}
