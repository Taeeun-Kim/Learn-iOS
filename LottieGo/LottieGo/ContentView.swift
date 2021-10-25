//
//  ContentView.swift
//  LottieGo
//
//  Created by Taeeun Kim on 25.10.21.
//

import SwiftUI

struct ContentView: View {
    
    @State var animationInProgress = false
    
    var body: some View {
        VStack {
            Text("Lottie Go")
                .font(.title)
                .bold()
                .padding()
                .padding(.top, 100)
            
            Button {
                animationInProgress.toggle()
            } label: {
                Text("Touch")
                    .font(.title2)
                    .bold()
            }
            
            Spacer()

            if animationInProgress {
                LottieView(animationInProgress: $animationInProgress)
                    .frame(width: 300, height: 200)
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
