//
//  UnitTestingView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 5/7/24.
//

import SwiftUI

struct UnitTestingView: View {
    @StateObject private var vm: UnitTestingViewModel
    
    init() {
        _vm = StateObject(wrappedValue: UnitTestingViewModel(isPremium: true))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingView()
}
