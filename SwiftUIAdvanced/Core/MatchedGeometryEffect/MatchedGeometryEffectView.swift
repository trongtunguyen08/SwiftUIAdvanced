//
//  MatchedGeometryEffectView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 1/7/24.
//

import SwiftUI

struct MatchedGeometryEffectView: View {
    let categories: [String] = ["Home", "Community", "Profile"]
    @Namespace private var namespace
    @State private var selectedCategory: String = ""
    
    var body: some View {
        VStack {
            HStack {
                ForEach(categories, id: \.self) { category in
                    ZStack {
                        if selectedCategory == category {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.teal)
                                .frame(height: 55)
                                .matchedGeometryEffect(id: "category_background_id", in: namespace)
                        }
                            
                        
                        Text(category)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.selectedCategory = category
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear(perform: {
            guard let category = categories.first else { return }
            self.selectedCategory = category
        })
    }
}

#Preview {
    MatchedGeometryEffectView()
}
