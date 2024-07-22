//
//  FeatureCardCell.swift
//  SwipeOnboarding
//
//  Created by Nitin Kumar on 22/07/24.
//

import SwiftUI

struct FeatureCardCell: View {
    var title: String
    var description: String
    var imageName: String
    var backgroundColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .frame(height: 24)
                .foregroundStyle(.white)
                .padding(4)
                .background(Circle().foregroundColor(backgroundColor))
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.black)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.black)
            }
            Spacer()
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.white.opacity(0.3)))
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct FeatureListView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("... and many more!")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.black)
            ScrollView(showsIndicators: false) {
                ForEach(features, id: \.title) { feature in
                    FeatureCardCell(title: feature.title, description: feature.description, imageName: feature.imageName, backgroundColor: feature.backgroundColor)
                }
            }
            Spacer()
            TransparentMaterialButton(width: 200) {
                
            } content: {
                Text("Next")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
            }
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    FeatureListView()
}
