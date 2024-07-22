//
//  View+.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import Foundation
import SwiftUI

extension View {
    func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
        self.background(
            GeometryReader { geometry in
                Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
