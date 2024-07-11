//
//  GenericsView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import SwiftUI

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
    
}

class GenericViewModel: ObservableObject {
    @Published var stringModel = GenericModel(info: "Hello world!")
    @Published var boolModel = GenericModel(info: true)
    
    func removeInfo() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
    }
}

struct GenericView<T:View>: View {
    let content: T
    var body: some View {
        Text("ABC")
        content
    }
}

struct GenericsView: View {
    @StateObject private var vm = GenericViewModel()
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            GenericView(content: Text("abc"))
            Text(vm.stringModel.info ?? "no string data")
            Text(vm.boolModel.info?.description ?? "no bool data")
        }
        .onTapGesture {
            vm.removeInfo()
        }
    }
}

#Preview {
    GenericsView()
}
