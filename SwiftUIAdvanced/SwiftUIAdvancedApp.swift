//
//  SwiftUIAdvancedApp.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 1/7/24.
//

import SwiftUI

@main
struct SwiftUIAdvancedApp: App {
    let curentUserIsSignedIn: Bool
    
    init() {
//        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITests_startSignIn") ? true : false
        let value = ProcessInfo.processInfo.environment["-UITests_startSignIn2"]
        let userIsSignedIn: Bool = value == "true" ? true : false
        self.curentUserIsSignedIn = userIsSignedIn
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
