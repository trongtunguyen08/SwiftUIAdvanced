//
//  SignInView_UITests.swift
//  SwiftUIAdvanced_UITests
//
//  Created by Tu Nguyen on 8/7/24.
//

import XCTest

final class SignInView_UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        //app.launchArguments = ["-UITests_startSignIn"]
        //app.launchEnvironment = ["-UITests_startSignIn2" : true"]
        app.launch()
        
        let menu = app.collectionViews.staticTexts["UITesting"]
        menu.tap()
        
        let textField = app.textFields["SignUpTextField"]
        textField.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let aKey2 = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey2.tap()
        aKey2.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SignInView_navBar_shouldBeDisplayed() {
        // Given
        
        // When
        let navBar = app.navigationBars["Welcome!"].staticTexts["Welcome!"]
        
        // Then
        XCTAssertTrue(navBar.exists)
    }
    
    func test_SignInView_alertMessage_shouldDisplayAlert() {
        // Given
        
        // When
        let alertButton = app.staticTexts["AlertButton"]
        alertButton.tap()
        
        let alert = app.alerts["Welcome to the App"]
        
        // Then
        XCTAssertTrue(alert.exists)
    }
    
    func test_SignInView_alertMessage_shouldDisplayAndDismissAlert() {
        // Given
        
        // When
        let alertButton = app.staticTexts["AlertButton"]
        alertButton.tap()
        
        let alert = app.alerts["Welcome to the App"]
        XCTAssertTrue(alert.exists)
        
        let alertOKButton = app.alerts.buttons["OK"]
        let alertOkButtonexist = alertButton.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(alertOkButtonexist)
        alertOKButton.tap()
        
        let alertExist = alert.waitForExistence(timeout: 2.0)
        
        // Then
        XCTAssertFalse(alertExist)
        XCTAssertFalse(alert.exists)
    }
    
    func test_SignInView_navigateButton_shouldNavigateToDestination() {
        // Given
        sleep(2)
        
        // When
        let welcomeText = app.navigationBars.staticTexts["Welcome!"]
        XCTAssertTrue(welcomeText.exists)
        
        let navigateButton = app.buttons["NavigationLinkToDestination"]
        navigateButton.tap()
        
        // Then
        let destination = app.staticTexts["Destination"]
        XCTAssertTrue(destination.exists)
        
        let backButton = app.navigationBars.buttons["Back"]
        XCTAssertTrue(backButton.exists)
        
        XCTAssertFalse(welcomeText.exists)
        
    }
    
    func test_SignInView_navigateButton_shouldNavigateToDestinationAndGoBack() {
        // Given
        sleep(2)
        
        // When
        let navigateButton = app.buttons["NavigationLinkToDestination"]
        navigateButton.tap()
        
        // Then
        let destination = app.staticTexts["Destination"]
        XCTAssertTrue(destination.exists)
        
        let backButton = app.navigationBars.buttons["Back"]
        backButton.tap()
        
        let welcomeText = app.navigationBars.staticTexts["Welcome!"]
        XCTAssertTrue(welcomeText.exists)
        XCTAssertFalse(destination.exists)
        XCTAssertFalse(backButton.exists)
    }
}
