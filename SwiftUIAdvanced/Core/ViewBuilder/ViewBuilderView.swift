//
//  ViewBuilderView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import SwiftUI

struct HeaderRegularView: View {
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .bold()
            
            if let description {
                Text(description)
            }
            
            if let iconName {
                Image(systemName: iconName)
            }
            
            Divider()
        }
    }
}

struct GenericHeaderView<T:View>: View {
    let title: String
    let content: T
    
    init(title: String, @ViewBuilder content: () -> T) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .bold()
            
            content
            
            Divider()
        }
    }
}

struct ViewBuilderView: View {
    var body: some View {
        VStack {
            HeaderRegularView(title: "Header Title", description: "Description", iconName: nil)
            
            HeaderRegularView(title: "Header Title", description: nil, iconName: nil)
            
            HeaderRegularView(title: "Header Title", description: nil, iconName: "heart.fill")
            
            GenericHeaderView(title: "Generic Header") {
                HStack {
                    Text("Hello")
                    Image(systemName: "bolt.fill")
                }
            }

            
            Spacer()
        }
        .padding()
    }
    
}

struct LocalViewBuilder: View {
    enum ViewType {
        case one, two, three
        
        fileprivate var viewOne: some View {
            Text("ABC")
        }
        
        fileprivate var viewTwo: some View {
            HStack {
                Text("Hello")
                Image(systemName: "heart.fill")
            }
        }
        
        fileprivate var viewThree: some View {
            VStack {
                Text("Hello World")
                Image(systemName: "heart.fill")
                Image(systemName: "bolt.fill")
            }
        }
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one:
            type.viewOne
        case .two:
            type.viewTwo
        case .three:
            type.viewThree
        }
    }
}

#Preview {
    //ViewBuilderView()
    LocalViewBuilder(type: .two )
}
