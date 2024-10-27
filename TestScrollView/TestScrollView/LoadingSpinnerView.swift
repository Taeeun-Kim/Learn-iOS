//
//  LoadingSpinnerView.swift
//  TestScrollView
//
//  Created by Taeeun Kim on 27.10.2024.
//

import SwiftUI
import Combine
import Lottie

struct LoadingSpinnerView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var currentFrame: Double = 0
    @State private var targetFrame: Double = 0
    @State private var timer: AnyCancellable?
    
    private var progress: Double
    private var size: CGFloat
    private let endFrame: Double = 53
    
    init(
        size: CGFloat,
        progress: Double = 1
    ) {
        self.size = size
        self.progress = progress
    }

    var body: some View {
        LottieView(
            animation: .named(
                colorScheme == .light
                ? "loading_spinner_light" // frame range (0-65)
                : "loading_spinner_dark" // frame range (0-65)
            )
        )
        .playbackMode(playbackMode)
        .frame(width: size, height: size)
        .onChange(of: progress) { newProgress in
            targetFrame = newProgress * endFrame // Map progress (0-1) to frame range (0-65)
        }
        .onAppear {
            startFrameUpdateTimer()
        }
        .onDisappear {
            timer?.cancel()
        }
    }

    private var playbackMode: LottiePlaybackMode {
        if progress < 1 {
            return .paused(at: .frame(currentFrame))
        } else {
            return .playing(.fromFrame(0, toFrame: endFrame, loopMode: .loop))
        }
    }
    
    private func startFrameUpdateTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                updateFrame()
            }
    }
    
    private func updateFrame() {
        let frameStep: Double = 0.5 // Adjust this for smoother or faster frame updates
        if currentFrame < targetFrame {
            currentFrame = min(currentFrame + frameStep, targetFrame)
        } else if currentFrame > targetFrame {
            currentFrame = max(currentFrame - frameStep, targetFrame)
        }
    }
}

#Preview {
    LoadingSpinnerView(
        size: 35,
        progress: 1
    )
}
