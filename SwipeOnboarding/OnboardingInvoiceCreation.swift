//
//  OnboardingInvoiceCreation.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import SwiftUI

struct OnboardingInvoiceCreation: View {
    var namespace: Namespace.ID
    
    private enum AnimationProperties {
        static let animationSpeed: Double = 10
        static let timerDuration: TimeInterval = 1
        static let blurRadius: CGFloat = 100
        static let createInvoiceDelay: Double = 2.5
        static let createInvoiceAnimationDuration: Double = 0.8
        static let textMoveUpDuration: Double = 0.5
    }
    
    @ObservedObject private var animator = CircleAnimator(colors: GradientColors.all)
    @State private var showCreateInvoice = false
    @State private var isCreateInvoiceButtonTapped = false
    @State private var showFeatureListView = false
    
    var body: some View {
        ZStack {
            ForEach(animator.circles) { circle in
                MovingCircle(originOffset: circle.position)
                    .foregroundColor(circle.color)
            }
            .zIndex(1)
            .blur(radius: AnimationProperties.blurRadius)
            .ignoresSafeArea(.all)
            
            Group {
                if !showCreateInvoice {
                    AnimatedOnboardingFirstView(showInvoiceScreen: $showCreateInvoice, namespace: namespace)
                } else if !isCreateInvoiceButtonTapped {
                    VStack {
                        HStack {
                            Spacer()
                            TransparentMaterialButton(width: 50) {
                                print("Button tapped!")
                            } content: {
                                Text("Skip")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .bold))
                            }
                        }
                        .padding(.horizontal, 16)
                        Spacer()
                        Text("Let's try creating an invoice!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.black)
                        VStack {
                            CreateInvoiceView(shouldShowInvoice: $isCreateInvoiceButtonTapped)
                        }
                        .frame(width: 350, height: 500)
                        .background(Color(hex: "#EBEBEB"))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .transition(.opacity)
                        Spacer()
                    }
                } else if !showFeatureListView {
                    InvoiceTemplateView(showNextView: $showFeatureListView)
                } else {
                    FeatureListView()
                }
            }
            .zIndex(2)
        }
        .animation(.default, value: showCreateInvoice)
        .animation(.default, value: isCreateInvoiceButtonTapped)
        .animation(.default, value: showFeatureListView)
    }
}

private enum GradientColors {
    static var all: [Color] {
        [
            Color(hex: "#1A3DCC"),
            Color(hex: "#2754FF"),
            Color(hex: "#4D74FF"),
            Color(hex: "#7392FF"),
            Color(hex: "#99B0FF")
        ]
    }
    static var backgroundColor: Color {
        Color(#colorLiteral(red: 0.003799867816,
                            green: 0.01174801588,
                            blue: 0.07808648795,
                            alpha: 1)
        )
    }
}

private struct MovingCircle: Shape {
    var originOffset: CGPoint
    
    var animatableData: CGPoint.AnimatableData {
        get {
            originOffset.animatableData
        }
        set {
            originOffset.animatableData = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let adjustedX = rect.width * originOffset.x
        let adjustedY = rect.height * originOffset.y
        let smallestDimension = min(rect.width, rect.height)
        
        path.addArc(center: CGPoint(x: adjustedX, y: adjustedY), radius: smallestDimension/2, startAngle: .zero, endAngle: .degrees(360), clockwise: true)
        
        return path
    }
}

private class CircleAnimator: ObservableObject {
    class Circle: Identifiable {
        internal init(position: CGPoint, color: Color) {
            self.position = position
            self.color = color
        }
        var position: CGPoint
        let id = UUID().uuidString
        let color: Color
    }
    
    @Published private(set) var circles: [Circle] = []
    
    init(colors: [Color]) {
        circles = colors.map({color in
            Circle(position: CircleAnimator.generateRandomPosition(), color: color)})
    }
    
    func animate() {
        objectWillChange.send()
        for circle in circles {
            circle.position = CircleAnimator.generateRandomPosition()
        }
    }
    
    static func generateRandomPosition() -> CGPoint {
        CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
    }
}
