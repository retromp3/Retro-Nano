//
//  PageView.swift
//  Retro Watch WatchKit Extension
//
//  Created by Sakun on 4/26/21.
//

import Foundation
import SwiftUI

struct PagesContainer <Content : View> : View {
    let contentCount: Int
    @State var index: Int = 0
    let content: Content
    @GestureState private var translation: CGFloat = 0
    
    init(contentCount: Int, @ViewBuilder content: () -> Content) {
        self.contentCount = contentCount
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack (spacing: 0){
                    self.content
                        .frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.index) * geometry.size.width)
                .offset(x: self.translation)
                .animation(.interactiveSpring())
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }.onEnded { value in
                        var weakGesture : CGFloat = 0
                        if value.translation.width < 0 {
                            weakGesture = -60
                        } else {
                            weakGesture = 60
                        }
                        let offset = (value.translation.width + weakGesture) / geometry.size.width
                        let newIndex = (CGFloat(self.index) - offset).rounded()
                        self.index = min(max(Int(newIndex), 0), self.contentCount - 1)
                    }
                )
                HStack {
                    
                    ForEach(0..<self.contentCount) { num in
                        Circle().frame(width: 5, height: 5)
                            .padding(.top, 10)
                            .foregroundColor(self.index == num ? .primary : Color.secondary.opacity(0.5))
                    }
                }
            }
        }
    }
}
