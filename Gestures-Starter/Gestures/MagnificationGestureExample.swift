//
//  MagnificationGesture.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-16.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct MagnificationGestureExample: View {
    
    @State private var currentMagnification: CGFloat = 1
    @GestureState private var pinchMagnification: CGFloat = 1
    
    var body: some View {
        Circle()
            .fill(Color.red)
            .shadow(radius: 20)
            .frame(width: 100)
            .scaleEffect(currentMagnification * pinchMagnification)
            .gesture(MagnificationGesture()
                        .updating($pinchMagnification) { value, state, _ in
                            state = value
                        }
                        .onEnded{self.currentMagnification *= $0} // $0는 pinchmagnification
                     // 아하 그냥 위에 scaleEffect를 다시 저장해주는 것
            )
    }
}

struct MagnificationGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureExample()
    }
}
