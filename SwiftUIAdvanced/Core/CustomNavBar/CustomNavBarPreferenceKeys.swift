//
//  CustomNavBarPreferenceKeys.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 4/7/24.
//

import Foundation
import SwiftUI

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarSubtitlePreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct CustomNavBackButtonHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    private func customNavigationBarBackButtonHidden(_ hidden: Bool = true) -> some View {
        self.preference(key: CustomNavBackButtonHiddenPreferenceKey.self, value: hidden)
    }
    
    private func customNavigationTitle(_ title: String) -> some View {
        self.preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
    
    private func customNavigationSubtitle(_ subtitle: String? = nil) -> some View {
        self.preference(key: CustomNavBarSubtitlePreferenceKey.self, value: subtitle)
    }
    
    func customNavBarItems(title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        self
            .customNavigationBarBackButtonHidden(backButtonHidden)
            .customNavigationTitle(title)
            .customNavigationSubtitle(subtitle)
    }
}
