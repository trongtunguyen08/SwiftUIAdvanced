//
//  NewMockDataService_Tests.swift
//  SwiftUIAdvanced_Tests
//
//  Created by Tu Nguyen on 5/7/24.
//

import XCTest
@testable import SwiftUIAdvanced
import Combine

final class NewMockDataService_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
    }
    
    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        // Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [
            UUID().uuidString,
            UUID().uuidString,
            UUID().uuidString,
        ]
        
        // When
        let dataService = NewMockDataService(items: items)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        // Then
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items, items3)
    }
    
    func test_NewMockDataService_downloadItemsWithEscaping_doesReturnValues() {
        // Given
        let dataService = NewMockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation =  XCTestExpectation()
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 3.0)
        XCTAssertFalse(items.isEmpty)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesReturnValues() {
        // Given
        let dataService = NewMockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation =  XCTestExpectation()
        dataService.downloadItemsWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(_):
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3.0)
        XCTAssertFalse(items.isEmpty)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        // Given
        let dataService = NewMockDataService(items: [])
        
        // When
        var items: [String] = []
        let expectation =  XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw URLError(.badServerResponse)")
        
        dataService.downloadItemsWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    let returnedError = error as? URLError
                    XCTAssertEqual(returnedError, URLError(.badServerResponse))
                    if returnedError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation, expectation2], timeout: 3.0)
        XCTAssertEqual(items.count, dataService.items.count)
    }
}