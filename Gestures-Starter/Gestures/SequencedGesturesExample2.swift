//
//  SequencedGesturesExample2.swift
//  Gestures
//
//  Created by Taeeun Kim on 30.04.21.
//  Copyright © 2021 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct SequencedGesturesExample2: View {
    
    @State private var postion = CGSize.zero
    @GestureState var pressDragState = PressDragState.inactive
    
    enum PressDragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var isActive: Bool {
            switch self {
            case .inactive:
                return false
            default:
                return true
            }
        }
        
        var translation: CGSize {
            switch self {
            case .dragging(translation: let translation):
                return translation
            default:
                return .zero
            }
        }
        
        var isNotDragging: Bool {
            switch self {
            case .dragging:
                return false
            default:
                return true
            }
        }
    }
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 0.5)
        
        let dragGesture = DragGesture()
            
        let longPressBeforeDragGesture = longPressGesture
            .sequenced(before: dragGesture)
            .updating($pressDragState) { value, state, _ in
                switch value {
                case .first(true):
                    state = .pressing
                case .second(true, let drag):
                    state = .dragging(translation: drag?.translation ?? .zero)
                default:
                    state = .inactive
                }
            }
            .onEnded { value in
                switch value {
                case .second(true, let drag):
                    postion.width += drag?.translation.width ?? 0
                    postion.height += drag?.translation.height ?? 0
                default:
                    break
                }
            }
        
        return Circle()
            .fill(Color.red)
            .shadow(radius: 20)
            .frame(width: 100)
            .scaleEffect(pressDragState.isActive ? 1.5 : 1)
            .offset(x: postion.width + pressDragState.translation.width,
                    y: postion.height + pressDragState.translation.height)
            .animation(pressDragState.isNotDragging ? .easeInOut(duration: 0.5) : nil)
            .gesture(longPressBeforeDragGesture)
    }
}

struct SequencedGesturesExample2_Previews: PreviewProvider {
    static var previews: some View {
        SequencedGesturesExample()
    }
}
