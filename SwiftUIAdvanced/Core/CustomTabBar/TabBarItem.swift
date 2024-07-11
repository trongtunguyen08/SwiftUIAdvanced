//
//  TabBarItem.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, favorite, profile
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorite: return "Favorites"
        case .profile: return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .favorite: return "heart"
        case .profile: return "person"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.red
        case .favorite: return Color.blue
        case .profile: return Color.green
        }
    }
}
