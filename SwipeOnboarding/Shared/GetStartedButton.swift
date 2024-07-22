//
//  GetStartedButton.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import Foundation
import SwiftUI

struct GetStartedButton: View {
    
    var buttonText: String
    @State var isTouched: Bool = false
    @Binding var shouldShowBottomSheet: Bool
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            Text(buttonText)
                .font(.interBold(.textSizeNormalLarge))
                .frame(minWidth: 0, maxWidth: .infinity)
            
            
            
            Image(systemName: "arrow.right")
                .resizable()
                .scaledToFit()
                .font(Font.system(size: .textSizeNormalLarge, weight: .semibold))
                .frame(width: 22, height: 22)
                .padding(.trailing, 12)
                

        }
        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
        .foregroundColor(Color.white)
            .background(Color("AccentColor"))
            .cornerRadius(12)
            .onTapGesture {
                self.isTouched = true
                withAnimation {
                    self.shouldShowBottomSheet.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                    self.isTouched = false
                }
            }
            .scaleEffect(isTouched ? 0.95 : 1.0)
            .animation (.linear (duration: 0.10), value: isTouched)
            .padding(12)
    }
}


extension View {
    func onTouchDownGesture(callback: @escaping () -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(callback: callback))
    }
}

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !self.tapped {
                        self.tapped = true
                        self.callback()
                    }
                }
                .onEnded { _ in
                    self.tapped = false
                })
    }
}


struct GetStartedButton_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedButton(buttonText: "Get Started", isTouched: false, shouldShowBottomSheet: .constant(false))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.blue)
            .ignoresSafeArea(.all)
    }
}
