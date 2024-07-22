//
//  SwipeOnboardingApp.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 20/07/24.
//

import SwiftUI
import TipKit
@main
struct SwipeOnboardingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
    init() {
        try? Tips.configure([
            .displayFrequency(.immediate),
            .datastoreLocation(.applicationDefault)
        ])
    }
}
