//
//  LottieView.swift
//  LottieGo
//
//  Created by Taeeun Kim on 25.10.21.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    @Binding var animationInProgress: Bool
    
    func makeUIView(context: Context) -> some AnimationView {
        let lottieAnimationView = AnimationView(name: "81296-success")
        lottieAnimationView.play { complete in
            if complete {
                animationInProgress = false
            }
        }
        
        return lottieAnimationView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

