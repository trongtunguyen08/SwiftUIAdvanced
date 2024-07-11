//
//  UITestingView_UITests.swift
//  SwiftUIAdvanced_UITests
//
//  Created by Tu Nguyen on 8/7/24.
//

import XCTest

final class UITestingView_UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {

    }
    
    func test_UITestingView_signUpButton_shouldNotSignIn() {
        // Given
        let menu = app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["UITesting"]/*[[".cells",".buttons[\"UITesting\"].staticTexts[\"UITesting\"]",".staticTexts[\"UITesting\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        menu.tap()
        
        // When
        let textField = app.textFields["SignUpTextField"]
        textField.tap()
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome!"].staticTexts["Welcome!"]
        
        // Then
        XCTAssertFalse(navBar.exists)
    }

    func test_UITestingView_signUpButton_shouldSignIn() {
        // Given
        let menu = app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["UITesting"]/*[[".cells",".buttons[\"UITesting\"].staticTexts[\"UITesting\"]",".staticTexts[\"UITesting\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        menu.tap()
        
        // When
        let textField = app.textFields["SignUpTextField"]
        textField.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let aKey2 = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey2.tap()
        aKey2.tap()
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome!"].staticTexts["Welcome!"]
        
        // Then
        XCTAssertTrue(navBar.exists)
    }
    
    
}
