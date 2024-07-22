//
//  Test.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import SwiftUI

enum ActionState {
    case initial
    case loading
    case finish
}

enum SlidingDirection: CGFloat {
    case ltr = 1
    case rtl = -1
}

private struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(1)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .animation(.default, value: configuration.isPressed)
    }
}

struct DraggableView: View {
    
    let maxDraggableWidth: CGFloat
    let actionFunction: () async -> Void
    let slidingDirection: SlidingDirection
    
    @State var actionState: ActionState = ActionState.initial
    
    private let minWidth: CGFloat = 50
    private let imagePadding: CGFloat = 4
    @State private var width: CGFloat = 50
    @State private var iconOpacity: Double = 1
    
    var body: some View {
        let opacity: Double = (width/maxDraggableWidth)
        RoundedRectangle(cornerRadius: 16)
            .fill(actionState == .finish ? Color("AccentColor").opacity(opacity) : Color("AccentColor").opacity(opacity))
            .frame(width: width)
            .overlay(
                Button(action: {}, label: {
                    ZStack {
                        Image(systemName: "chevron.right")
                            .opacity(actionState == .initial ? iconOpacity : 0)
                        
                        if actionState == .loading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color("AccentColor")))
                        }
                        
                        Image(systemName: "checkmark")
                            .opacity(actionState == .finish ? iconOpacity : 0)
                    }
                    .animation(.easeInOut(duration: 0.3), value: iconOpacity)
                })
                .buttonStyle(CustomButtonStyle())
                .disabled(actionState != .initial)
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .foregroundStyle(Color("AccentColor"))
                .frame(width: minWidth - 2 * imagePadding, height: minWidth - 2 * imagePadding)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("AccentColor"), lineWidth: 4)
                        .fill(.white)
                )
                .padding(.all, imagePadding),
                alignment: (slidingDirection == .ltr) ? .trailing : .leading
            )
            .highPriorityGesture(
                DragGesture()
                    .onChanged { value in
                        guard (actionState == .initial) else {return}
                        if value.translation.width * slidingDirection.rawValue > 0 {
                            width = min((value.translation.width * slidingDirection.rawValue) + minWidth, maxDraggableWidth)
                        }
                    }
                    .onEnded {_ in
                        guard (actionState == .initial) else {return}
                        
                        if width < maxDraggableWidth {
                            width = minWidth
                            return
                        }
                        withAnimation(.spring().delay(0.5)) {
                            actionState = .loading
                        }
                        
                        Task {
                            await actionFunction()
                            DispatchQueue.main.async {
                                actionState = .finish
                            }
                        }
                    }
            )
            .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0), value: width)
    }
}

struct BackgroundView: View {
    let slidingDirection: SlidingDirection
    let isFinished: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color("AccentColor").opacity(0.4))
            .overlay(
                HStack {
                    Text("Get Swiping...")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                }
                    .foregroundStyle(Color.white.opacity(0.6))
                ,
                alignment: .center
            )
    }
}

struct SlideToActionButton: View {
    let actionFunction: () async -> Void
    let slidingDirection: SlidingDirection
    
    @State private var isFinished = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:  (slidingDirection == .ltr) ? .leading : .trailing) {
                BackgroundView(slidingDirection: slidingDirection, isFinished: isFinished)
                DraggableView(maxDraggableWidth: geometry.size.width, actionFunction: {
                    await actionFunction()
                    isFinished = true
                }, slidingDirection: slidingDirection)
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    func mySleep() async {
        sleep(2)
    }
    let actionFunction: () async -> Void = {
        await mySleep()
    }
    return SlideToActionButton(actionFunction: actionFunction, slidingDirection: .ltr)
        .padding(.horizontal, 50)
    
}
