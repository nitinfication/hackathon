//
//  InvoiceTemplateView.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 22/07/24.
//

import SwiftUI

struct InvoiceTemplateView: View {
    @State private var showCardStack = false
    @State private var opacity = 0.0
    @State private var scale = 0.8
    @Namespace var namespace
    @Binding var showNextView: Bool
    
    // For haptic feedback
    let impact = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(showCardStack ? "And you can choose between multiple templates" : "Voila!\nYour invoice is created!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .bold))
                    .lineLimit(2, reservesSpace: true)
                    .animation(.easeInOut, value: showCardStack)
                
                if showCardStack {
                    CardStack(demoEntries) { entry in
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.white)
                            .overlay(
                                Image(entry.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 350)
                            )
                            .cornerRadius(10)
                            .padding(1)
                            .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 2)
                            .frame(width: 250, height: 350)
                    }
                    .matchedGeometryEffect(id: "template", in: namespace)
                    .opacity(opacity)
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 0.5), value: opacity)
                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: scale)
                } else {
                    Image("template1")
                        .resizable()
                        .scaledToFit()
                        .matchedGeometryEffect(id: "template", in: namespace)
                        .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 2)
                        .frame(width: 250, height: 350)
                        .opacity(opacity)
                        .scaleEffect(scale)
                }
                Spacer()
                if showCardStack {
                    TransparentMaterialButton(width: 200) {
                        withAnimation {
                            showNextView = true
                        }
                    } content: {
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .matchedGeometryEffect(id: "startButton", in: namespace)
                    .opacity(opacity)
                    .scaleEffect(scale)
                }
            }
        }
        .matchedGeometryEffect(id: "createButton", in: namespace)
        .onAppear {
            animateAppearance()
        }
    }
    
    private func animateAppearance() {
        let initialDelay: TimeInterval = 0.5
        let fadeDuration: TimeInterval = 1.5
        let hapticInterval: TimeInterval = 0.1
        let hapticCount = Int(fadeDuration / hapticInterval)
        
        for i in 0..<hapticCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + initialDelay + Double(i) * hapticInterval) {
                impact.impactOccurred(intensity: CGFloat(Float(i) / Float(hapticCount)))
            }
        }
    
        withAnimation(.easeInOut(duration: fadeDuration).delay(initialDelay)) {
            opacity = 1.0
            scale = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + initialDelay + fadeDuration + 0.5) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showCardStack = true
            }
        }
    }
}
