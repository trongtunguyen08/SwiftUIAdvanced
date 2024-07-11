//
//  FuturesView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 9/7/24.
//

import SwiftUI

struct FuturesView: View {
    @StateObject private var vm = FuturesViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

#Preview {
    FuturesView()
}
