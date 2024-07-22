//
//  Color+.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 22/07/24.
//

import SwiftUI

struct AnimatedOnboardingFirstView: View {
    @State private var textOffset: CGFloat = 0
    @Binding var showInvoiceScreen: Bool
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(.top, 60)
                .matchedGeometryEffect(id: "logo", in: namespace)
            Spacer()
            AnimatedTextView(duration: 1.5)
                .offset(y: textOffset)
            Spacer()
            TransparentMaterialButton(width: 200) {
                showInvoiceScreen.toggle()
            } content: {
                Text("Next")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
            }
            .matchedGeometryEffect(id: "startButton", in: namespace)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    func toHex() -> String {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return "#000000"
        }
        
        let r = components[0]
        let g = components[1]
        let b = components[2]
        
        return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}

struct AnimatedTextView: View {
    let staticWord: String = "Simple"
    let changingWords: [String] = ["Invoicing", "Accounting", "E-Invoice", "GST Billing", "Payments"]
    @State private var currentIndex = 0
    var duration: Double
    var body: some View {
        HStack {
            Text(staticWord)
                .font(.system(size: 32, weight: .bold))
            Text(changingWords[currentIndex])
                .font(.system(size: 32, weight: .bold))
                .contentTransition(.numericText())
            //                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .id(currentIndex)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .onAppear {
            startAnimation()
        }
    }
    
    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                currentIndex = (currentIndex + 1) % changingWords.count
            }
        }
    }
}

