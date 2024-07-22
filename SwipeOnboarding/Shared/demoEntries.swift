//
//  demoEntries.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 22/07/24.
//

import Foundation
import SwiftUI

struct OnboardingDemoEntries: Identifiable {
    let imageName: String
    
    var id: String {
        imageName
    }
}
let demoEntries = [
    OnboardingDemoEntries(imageName: "template1"),
    OnboardingDemoEntries(imageName: "template2"),
    OnboardingDemoEntries(imageName: "template3"),
    OnboardingDemoEntries(imageName: "template4"),
    OnboardingDemoEntries(imageName: "template5")
]

let colors: [Color] = [.blue, .green, .red, .purple, .orange, .yellow, .pink]
let features: [FeatureCardCell] = [
    FeatureCardCell(
        title: "Create Invoices, Purchases & Quotations",
        description: "Track sales, manage inventory, and create GST-compliant invoices easily.",
        imageName: "doc.text",
        backgroundColor: .blue
    ),
    FeatureCardCell(
        title: "Share on WhatsApp with payment links",
        description: "Share invoices and purchase orders on WhatsApp and Email.",
        imageName: "arrow.up.right.square",
        backgroundColor: .green
    ),
    FeatureCardCell(
        title: "GST filings made easy",
        description: "Quickly generate GST reports to file returns instantly.",
        imageName: "checkmark.seal",
        backgroundColor: .red
    ),
    FeatureCardCell(
        title: "Manage inventory",
        description: "Download and update inventory reports quickly, saving you time.",
        imageName: "archivebox",
        backgroundColor: .purple
    ),
    FeatureCardCell(
        title: "Get payments faster",
        description: "Send payment links and reminders to receive quick payments.",
        imageName: "creditcard",
        backgroundColor: .orange
    ),
    FeatureCardCell(
        title: "Get your store Online",
        description: "Set up and share your online store to receive orders and payments.",
        imageName: "cart",
        backgroundColor: .yellow
    ),
    FeatureCardCell(
        title: "Powerful business analytics and Reports",
        description: "Generate comprehensive analytics and reports on sales and user behavior.",
        imageName: "chart.bar",
        backgroundColor: .pink
    ),
    FeatureCardCell(title: "Customisation", 
                    description: "Yes, you can add your Company Name, GSTIN, Address and Logo to your invoices.",
                    imageName: "gearshape", 
                    backgroundColor: .mint)
]
