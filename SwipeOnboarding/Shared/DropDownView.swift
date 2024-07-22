//
//  DropDownView.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 22/07/24.
//

import SwiftUI

struct DropdownView: View {
    let placeholder: String
    let options: [String]
    let selectedOption: String?
    @Binding var isOpen: Bool
    let onSelectOption: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: { isOpen.toggle() }) {
                HStack {
                    Text(selectedOption ?? placeholder)
                        .foregroundColor(selectedOption == nil ? .gray : .black)
                    Spacer()
                    Image(systemName: isOpen ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            
            if isOpen {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(options, id: \.self) { option in
                        Button(action: { onSelectOption(option) }) {
                            Text(option)
                                .foregroundColor(.black)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .background(selectedOption == option ? Color.gray.opacity(0.2) : Color.clear)
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
        }
    }
}
