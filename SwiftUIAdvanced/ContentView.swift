//
//  ContentView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    ViewModifiersView()
                } label: {
                    Text("View Modifiers")
                }

                NavigationLink {
                    ButtonStylesView()
                } label: {
                    Text("Button Styles")
                }
                
                NavigationLink {
                    AnyTransitionView()
                } label: {
                    Text("Any Transition")
                }
                
                NavigationLink {
                    MatchedGeometryEffectView()
                } label: {
                    Text("Matched Geometry Effect")
                }
                
                NavigationLink {
                    CustomShapesView()
                } label: {
                    Text("Custom Shapes")
                }
                
                NavigationLink {
                    CustomShapesView()
                } label: {
                    Text("Generics")
                }
                
                NavigationLink {
                    ViewBuilderView()
                } label: {
                    Text("View Builder")
                }
                
                NavigationLink {
                    ScrollviewPreferenceKeyView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("PreferanceKey")
                }
                
                NavigationLink {
                    AppTabBarView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Custom TabBar")
                }
                
                NavigationLink {
                    AppNavBarView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Custom NavBar")
                }
                
                NavigationLink {
                    UIViewRepresentableView()
                } label: {
                    Text("UIViewRepresentable")
                }
                
                NavigationLink {
                    UIViewControllerRepresentableView()
                } label: {
                    Text("UIViewControllerRepresentable")
                }
                
                NavigationLink {
                    PrototolsView(colorTheme: DefaultColorTheme())
                } label: {
                    Text("Protocols")
                }
                
                NavigationLink {
                    DependencyInjectionView(dataService: ProductDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!))
                } label: {
                    Text("Dependency Injection")
                }
                
                NavigationLink {
                    UITestingView()
                } label: {
                    Text("UITesting")
                }
                
                NavigationLink {
                    CombineView(vm: CombineViewModel())
                } label: {
                    Text("Combine")
                }
                
                NavigationLink {
                    FuturesView()
                } label: {
                    Text("Futures")
                }
                
                NavigationLink {
                    CloudKitView()
                } label: {
                    Text("CloudKit")
                }
                
                NavigationLink {
                    TimelineView()
                } label: {
                    Text("TimelineView")
                }
            }
            .navigationTitle("SwiftUI Advanced")
        }
    }
}

#Preview {
    ContentView()
}
