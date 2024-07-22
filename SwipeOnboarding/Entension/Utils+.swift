//
//  Utils+.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import Foundation
import SwiftUI

func getIndexOpacity(_ index: Int, size: Int) -> Double {
    return Double(1 - Double(index) / Double(size)) * 0.9
}

func getIndexTransition(_ index: Int) -> some Transition {
    return .blurReplace(.upUp).animation(.bouncy.delay(Double(index) * 0.3))
}
