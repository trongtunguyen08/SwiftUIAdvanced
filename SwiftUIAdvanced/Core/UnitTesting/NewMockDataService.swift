//
//  NewMockDataService.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 5/7/24.
//

import Foundation
import Combine

protocol NewDataServicePrototol {
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ())
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServicePrototol {
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? ["ONE", "TWO", "THREE"]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(self.items)
            .tryMap { publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            }
            .eraseToAnyPublisher()
    }
}
