//
//  CombineDataService.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 8/7/24.
//

import Foundation
import Combine

class CombineDataService {
//    @Published var basicPublisher: String = ""
//    let currentPublisherValue = CurrentValueSubject<String,Error>("")
    let passthroughPublisher = PassthroughSubject<Int,Error>()
    let boolPublisher = PassthroughSubject<Bool,Error>()
    let intPublisher = PassthroughSubject<Int,Error>()
    
    init() {
        self.publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = Array(0..<10)
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
//                self.basicPublisher = items[x]
//                self.currentPublisherValue.send(items[x])
                self.passthroughPublisher.send(items[x])
                
                if ((x > 4) && (x < 8)) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999 )
                } else {
                    self.boolPublisher.send(false)
                }
                
                if x == items.indices.last {
                    self.passthroughPublisher.send(completion: .finished)
                    self.boolPublisher.send(completion: .finished)
                }
            }
        }
    }
}
