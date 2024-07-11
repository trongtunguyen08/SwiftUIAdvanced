//
//  CustomNavBarView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 4/7/24.
//

import SwiftUI

struct CustomNavBarView: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    let subtitle: String?
    let showBackButton: Bool
    
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }
            
            Spacer()
            
            headerSection
            
            Spacer()
            
            if showBackButton {
                backButton
                    .opacity(0.0)
            }
        }
        .tint(Color.white)
        .foregroundStyle(Color.white)
        .font(.headline)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            Color.green.ignoresSafeArea(edges: .top)
        )
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var headerSection: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            
            if let subtitle {
                Text(subtitle)
            }
        }
    }
}

#Preview {
    VStack {
        CustomNavBarView(title: "Title", subtitle: "Subtitle here", showBackButton: true)
        
        Spacer()
    }
    
}
