//
//  ContentView.swift
//  TestScrollView
//
//  Created by Taeeun Kim on 27.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var isRefreshing = false
    
    var body: some View {
        VStack {
            RefreshableList(
                id: "FileTrashViewFileList",
                isRefreshing: $isRefreshing,
                onRefresh: {
                    print("@@: onRefresh")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isRefreshing = false
                    }
                },
                refreshTriggerOffset: 59,
                header: {
                    Text("Header")
                        .padding([.horizontal, .top], 16)
                        .padding(.bottom, 8)
                },
                content: {
                    Group {
                        Text("text")
                        Text("text")
                        Text("text")
                        Text("text")
                        Text("text")
                        Text("text")
                        Text("text")
                    }
                },
                footer: {
                    Text("footer")
                        .padding([.horizontal, .top], 16)
                        .padding(.bottom, 8)
                }
            )
        }
    }
}

#Preview {
    ContentView()
}

struct RefreshableList<Header: View, Content: View, Footer: View>: View {
    
    @Binding private var isRefreshing: Bool
    
    @State private var offset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isAnimating = false
    @State private var isDragging = false
    @State private var showLoadingSpinner = false
    @State private var isHapticTriggered = false
        
    private let id: String
    private let onRefresh: () -> Void
    private let header: (() -> Header)?
    private let content: () -> Content
    private let footer: (() -> Footer)?
    private let clearBoxOffset: CGFloat = 50
    private let refreshTriggerOffset: CGFloat
    
    init(
        id: String,
        isRefreshing: Binding<Bool>,
        onRefresh: @escaping () -> Void,
        refreshTriggerOffset: CGFloat,
        header: (() -> Header)?,
        content: @escaping () -> Content,
        footer: (() -> Footer)?
    ) {
        self.id = id
        self._isRefreshing = isRefreshing
        self.onRefresh = onRefresh
        self.refreshTriggerOffset = refreshTriggerOffset
        self.header = header
        self.content = content
        self.footer = footer
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                List {
                    Color.clear
                        .frame(height: clearBoxOffset)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .transformAnchorPreference(
                            key: RefreshableListKey.self,
                            value: .bounds
                        ) {
                            $0.append(RefreshableListFrame(id: id, frame: geo[$1]))
                        }
                        .onPreferenceChange(RefreshableListKey.self) {
                            if let offset = $0.first?.frame.minY {
                                detectScrollOffset(offset: offset + clearBoxOffset)
                            }
                        }
                    
                    if let header {
                        header()
                    }
                    
                    content()
                    
                    if let footer {
                        footer()
                    }
                }
                .listStyle(.plain)
                .frame(height: geo.size.height + clearBoxOffset)
//                .background(Color.backgroundList)
                .offset(y: offset > 0 ? -clearBoxOffset + offset : -clearBoxOffset)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged{ gesture in
                            if !isRefreshing {
                                isDragging = true
                                dragOffset = max(0, gesture.translation.height)
                                print("@@: dragOffset: \(dragOffset)")
                            }
                        }
                        .onEnded { _ in
                            isDragging = false
                        }
                )
//                .applyCondition {
//                    if #available(iOS 16, *) {
//                        $0.scrollIndicators(.hidden)
//                    } else {
//                        $0
//                    }
//                }
            }
            
            if showLoadingSpinner || isRefreshing {
                LoadingSpinnerView(
                    size: 35,
                    progress: spinnerOpacity
                )
                    .padding(.vertical, 12)
                    .opacity(spinnerOpacity)
            }
        }
        .onChange(of: isRefreshing) { isRefreshing in
            if !isRefreshing {
                reset()
            }
        }
    }
    
    private var spinnerOpacity: Double {
        min(
            Double((dragOffset - refreshTriggerOffset) / refreshTriggerOffset),
            1.0
        )
    }
    
    private func reset() {
        if isAnimating {
            return
        }
        withAnimation(.easeInOut(duration: 0.2)) {
            showLoadingSpinner = false
            isAnimating = true
            isHapticTriggered = false
            offset = 0
            dragOffset = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isAnimating = false
        }
    }
    
    private func detectScrollOffset(offset: CGFloat) {
        guard offset >= 0, !isRefreshing, !isAnimating else {
            return
        }
        print("@@: offset \(offset)")
        
        if isDragging {
            showLoadingSpinner = true
            
            if
                !isHapticTriggered,
                offset > refreshTriggerOffset
            {
                isHapticTriggered = true
//                HapticManager.pullToRefresh()
            }
        } else {
            DispatchQueue.main.async {
                if offset > refreshTriggerOffset {
                    self.isRefreshing = true
                    self.onRefresh()
                    
                    withAnimation {
                        self.offset = refreshTriggerOffset
                    }
                } else {
                    self.reset()
                }
            }
        }
    }
}

struct RefreshableListFrame : Equatable {
    
    let id : String
    let frame : CGRect

    static func == (lhs: RefreshableListFrame, rhs: RefreshableListFrame) -> Bool {
        lhs.id == rhs.id && lhs.frame == rhs.frame
    }
}

struct RefreshableListKey : PreferenceKey {
    
    typealias Value = [RefreshableListFrame] // The list of view frame changes in a View tree.

    static var defaultValue: [RefreshableListFrame] = []

    /// When traversing the view tree, Swift UI will use this function to collect all view frame changes.
    static func reduce(value: inout [RefreshableListFrame], nextValue: () -> [RefreshableListFrame]) {
        value.append(contentsOf: nextValue())
    }
}

struct HapticManager {
    
    static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(type)
    }
    
    static func pullToRefresh() {
        HapticManager.impact(style: .medium)
    }
}
