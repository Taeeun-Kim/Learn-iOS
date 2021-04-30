//
//  ContentView.swift
//  DragGesture
//
//  Created by Taeeun Kim on 30.04.21.
//

import SwiftUI

struct DragGestureExample2: View {
    
    let topOffset: CGFloat = 80
    let bottomOffset: CGFloat = 120
    
    @State private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            Text("Hello World")
            
            Rectangle()
                .fill(Color.blue)
                .cornerRadius(30)
                .offset(y: topOffset + dragOffset.height + position.height)
                .gesture(DragGesture()
                            .onChanged({ self.dragOffset = $0.translation })
                            .onEnded({ (value) in
                                withAnimation(.spring()) {
                                    if self.position == .zero {
                                        // at the top...
                                        // 1. 위로 조금이라도 올리면
                                        // 2. 아래로 충분히 내리면
                                        if value.translation.height < 0 || value.translation.height < 150 {
                                            // 드래그를 위로 하면 -50, 이렇게 나옴, 그러면 다시 원상복귀
                                            // 드래그를 아래로 150 이상가면, 밑의 else 문으로
                                            self.position = .zero
                                        } else {
                                            // 드래그를 아래로 150 이상하면, 파란색 카드가 화면 스크린크기 - bottomOffset만큼 내려감
                                            // 값이 positive면, 밑으로 내려감
                                            self.position.height = UIScreen.main.bounds.height - self.bottomOffset
                                        }
                                    } else {
                                        // if we are at the bottom...
                                        // 첫번째 조건은, 아래로 조금이라도 올리면
                                        // 두번째 조건은, 위로 충분히 올리면
                                        if value.translation.height > 0 || value.translation.height > -150 {
                                            // 내려간 상태 그대로 유지
                                            self.position.height = UIScreen.main.bounds.height - self.bottomOffset
                                        } else {
                                            // 다시 위로 쭉 올라감
                                            self.position = .zero
                                        }
                                    }
                                    
                                    self.dragOffset = .zero
                                }
                            })
                )
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct DragGestureExample1: View {
    
    @State private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    var body: some View {
        
        Circle()
            .fill(Color.yellow)
            .shadow(radius: 20)
            .frame(width: 100)
            .offset(x: dragOffset.width + position.width, y: dragOffset.height + position.height)
            .gesture(DragGesture()
                        .onChanged({ value in
                            self.dragOffset = value.translation
                        })
                        .onEnded({ value in
                            self.position.width += value.translation.width
                            self.position.height += value.translation.height
                            self.dragOffset = .zero
                        })
            )
    }
}

struct ContentView: View {
    var body: some View {
        DragGestureExample2()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
