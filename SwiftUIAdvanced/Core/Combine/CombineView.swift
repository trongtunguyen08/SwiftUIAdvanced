//
//  CombineView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 8/7/24.
//

import SwiftUI

struct CombineView: View {
    @StateObject private var vm: CombineViewModel
    
    init(vm: CombineViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) { item in
                        Text(item)
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    if vm.error.isEmpty == false {
                        Text(vm.error)
                    }
                }
                
                VStack {
                    ForEach(vm.dataBools, id: \.self) { item in
                        Text(item.description)
                            .font(.largeTitle)
                            .bold()
                    }
                }
            }
        }
    }
}

#Preview {
    let vm = CombineViewModel()
    
    return CombineView(vm: vm)
}
