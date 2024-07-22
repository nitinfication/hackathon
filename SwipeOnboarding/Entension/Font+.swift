//
//  Font+.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import Foundation
import SwiftUI

extension CGFloat {
    static let textSizeExtraSmall : CGFloat = 10
    static let textSizeSmall : CGFloat = 12
    static let textSizeNormalSmall : CGFloat = 14
    static let textSizeNormal : CGFloat = 15
    static let textSizeNormalMedium : CGFloat = 18
    static let textSizeLarge : CGFloat = 22
    static let textSizeNormalLarge : CGFloat = 24
    static let textSizeExtraLarge : CGFloat = 28
    static let textSizeExtraExtraLarge : CGFloat = 34
    
    static let paddingSmall: CGFloat = 4
    static let paddingMedium: CGFloat = 8
    static let paddingLarge: CGFloat = 12
    static let paddingExtraLarge: CGFloat = 16
    static let paddingExtraExtraLarge: CGFloat = 20
}

extension Font {
    
    static func inter(_ value : CGFloat = .textSizeNormal) -> Font {
        return Font.system(size: value, weight: .medium)
    }
    
    static func interBold(_ value : CGFloat = .textSizeNormal) -> Font {
        return Font.system(size: value, weight: .bold)
    }
    
    static func interLight(_ value : CGFloat = .textSizeNormal) -> Font {
        return Font.system(size: value, weight: .regular)
    }
    
    static func interMedium(_ value : CGFloat = .textSizeNormal) -> Font {
        return Font.system(size: value, weight: .medium)
    }
    
    static func interSemiBold(_ value : CGFloat = .textSizeNormal) -> Font {
        return Font.system(size: value, weight: .semibold)
    }
}
