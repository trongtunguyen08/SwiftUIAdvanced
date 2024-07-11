//
//  SwiftUIAdvanced_Tests.swift
//  SwiftUIAdvanced_Tests
//
//  Created by Tu Nguyen on 5/7/24.
//

// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then

import XCTest
@testable import SwiftUIAdvanced
import Combine

final class SwiftUIAdvanced_Tests: XCTestCase {
    
    var viewModel: UnitTestingViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewModel = UnitTestingViewModel(isPremium: .random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
    }

    func test_UnitTestingViewModel_isPremium_showBeTrue() {
        // Given
        let isPremium: Bool = true
        
        // When
        let vm = UnitTestingViewModel(isPremium: isPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_showBeFalse() {
        // Given
        let isPremium: Bool = false
        
        // When
        let vm = UnitTestingViewModel(isPremium: isPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_showBeInjectedValue() {
        // Given
        let isPremium: Bool = Bool.random()
        
        // When
        let vm = UnitTestingViewModel(isPremium: isPremium)
        
        // Then
        XCTAssertEqual(vm.isPremium, isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_showBeInjectedValue_stress() {
        for _ in 0..<100 {
            // Given
            let isPremium: Bool = Bool.random()
            
            // When
            let vm = UnitTestingViewModel(isPremium: isPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, isPremium)
        }
    }
    
    func test_UnitTesingViewModel_dataArray_shouldBeEmpty() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTesingViewModel_dataArray_shouldAddItems() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let loopCount: Int = Int.random(in: 1..<1000)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTesingViewModel_dataArray_shouldNotAddBlankString() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTesingViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let item: String = "Nguyen Tu"
        vm.addItem(item: item)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTesingViewModel_selectedItem_shouldBeSelected() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let item: String = "Nguyen Tu"
        vm.addItem(item: item)
        vm.selectItem(item: item)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, item)
    }
    
    func test_UnitTesingViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        var dataArrays: [String] = []
        
        for _ in 0..<1000 {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            dataArrays.append(newItem)
        }
        
        let randomItem: String = dataArrays.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTesingViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString)) { error in
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTesingViewModel_saveItem_shouldThrowError_noData() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: "")) { error in
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.noData)
        }
    }
    
    func test_UnitTesingViewModel_saveItem_shouldSaveItem() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        var dataArrays: [String] = []
        
        for _ in 0..<1000 {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            dataArrays.append(newItem)
        }
        
        let randomItem: String = dataArrays.randomElement() ?? ""
        
        // Then
        XCTAssertFalse(randomItem.isEmpty)
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_UnitTesingViewModel_dowloadWithEscaping_shouldReturnItems() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.dowloadWithEscaping()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTesingViewModel_dowloadWithCombine_shouldReturnItems() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
}
