//
//  TipPromptView.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 22/07/24.
//

import SwiftUI

struct TipPromptView: View {
    let title: String
    let message: String
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            Text(message)
                .font(.subheadline)
        }
        .padding()
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.yellow, lineWidth: 1)
        )
    }
}
