//
//  DragGestureExample3.swift
//  Gestures
//
//  Created by Stewart Lynch on 2020-06-15.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct DragGestureExample2: View {
     var body: some View {
           ZStack {
               Text("Hello World")
               Rectangle()
                   .fill(Color.blue)
                   .cornerRadius(30)
                   .edgesIgnoringSafeArea(.all)
           }
       }
}

struct DragGestureExample2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureExample2()
    }
}
