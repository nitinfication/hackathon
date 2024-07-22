//
//  TransparentButton.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 22/07/24.
//

import SwiftUI

struct TransparentMaterialButton<Content: View>: View {
    let width: CGFloat
    let action: () -> Void
    let content: () -> Content
    let impact = UIImpactFeedbackGenerator(style: .medium)

    init(width: CGFloat, action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.width = width
        self.action = action
        self.content = content
    }
    
    var body: some View {
        Button(action: {
            impact.impactOccurred()
            action()
        }) {
            content()
                .frame(width: width)
                .padding(12)
                .background(.black.opacity(0.1))
                .cornerRadius(24)
        }
    }
}


#Preview {
    ZStack {
        Color.blue
        TransparentMaterialButton(width: 200) {
            print("Button tapped!")
        } content: {
            Text("Tap me")
                .foregroundColor(.primary)
        }
    }
}
