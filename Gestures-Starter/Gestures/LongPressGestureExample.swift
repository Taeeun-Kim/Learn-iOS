//
//  LongPressGestureExample.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-15.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct LongPressGestureExample: View {
    
    @State private var isLongPressed = false
    @GestureState private var isLongPressing = false
    
    var body: some View {
        Circle()
            .fill(isLongPressing ? Color.green : Color.red)
            .shadow(radius: 20)
            .frame(width: 200)
            .scaleEffect(isLongPressed ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 0.5))
            .gesture(LongPressGesture(minimumDuration: 1.0, maximumDistance: 400)
                        .onEnded({ _ in
                            self.isLongPressed.toggle()
                        })
                        // 첫번째는 @State 변수를 받아야해서 달러 사인
                        .updating($isLongPressing) { value, state, _ in
                            // 롱터치를 하면 value가 false -> true가 됨, 그리고 value는 $isLongPressing의 값
                            // state는 다시 원래 값으로 돌아감
                            state = value
                        }
            )
    }
}

//struct LongPressGestureView: View {
//    @GestureState var isDetectingLongPress = false
//    @State var completedLongPress = false
//
//    var longPress: some Gesture {
//        LongPressGesture(minimumDuration: 3)
//            .updating($isDetectingLongPress) { currentState, gestureState,
//                    transaction in
//                gestureState = currentState
//                transaction.animation = Animation.easeIn(duration: 2.0)
//            }
//            .onEnded { finished in
//                self.completedLongPress = finished
//            }
//    }
//
//    var body: some View {
//        Circle()
//            .fill(self.isDetectingLongPress ?
//                Color.red :
//                (self.completedLongPress ? Color.green : Color.blue))
//            .frame(width: 100, height: 100, alignment: .center)
//            .gesture(longPress)
//    }
//}

struct LongPressGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureExample()
    }
}
