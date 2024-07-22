//
//  MarqueeView.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import SwiftUI

struct MarqueeView<Content: View>: View {
    let content: () -> Content
    @State private var contentSize: CGSize = .zero
    @State private var scrollOffset: CGFloat = 0
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    content()
                        .measureSize { size in
                            contentSize = size
                            if !isAnimating {
                                scrollOffset = 0
                                startScrolling(viewWidth: geometry.size.width)
                            }
                        }
                    content()
                    content()
                }
                .offset(x: scrollOffset)
            }
            .disabled(true)
        }
        .mask(
            HStack(spacing: 0) {
                Rectangle().fill(Color.black)
                LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .clear]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 20)
            }
        )
    }
    
    private func startScrolling(viewWidth: CGFloat) {
        guard contentSize.width > 0 else { return }
        
        isAnimating = true
        let duration = Double(contentSize.width) / 50.0
        
        withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
            scrollOffset = -contentSize.width
        }
    }
}

