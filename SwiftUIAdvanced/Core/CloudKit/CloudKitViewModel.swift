//
//  CloudKitViewModel.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 10/7/24.
//

import Foundation
import CloudKit
import SwiftUI

final class CloudKitViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var fruits: [String] = []
    
    init() {
        checkStatus()
    }
    
    func addButtonPressed() {
        addItem()
    }
    
    
    private func addItem() {
        guard !text.isEmpty else { return }
        let newFruit = CKRecord(recordType: "Fruits")
        newFruit["name"] = text
        saveItem(item: newFruit)
    }
    
    private func saveItem(item: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(item) { [weak self] returnedRecord, returnedError in
            print("\(String(describing: returnedRecord))")
            print("\(String(describing: returnedError))")
            DispatchQueue.main.async {
                self?.text.removeAll()
            }
            self?.fetchItems()
        }
    }
    
    private func checkStatus() {
        CKContainer.default().accountStatus { [weak self] returnedAccountStatus, _ in
            DispatchQueue.main.async {
                switch returnedAccountStatus {
                case .available:
                    self?.fetchItems()
                default:
                    break
                }
            }
        }
    }
    
    private func fetchItems() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Fruits", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var returnedItems: [String] = []
        
        operation.recordMatchedBlock = { _, recordResult in
            switch recordResult {
            case .success(let record):
                guard let name = record["name"] as? String else { return }
                returnedItems.append(name)
            case .failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        operation.queryResultBlock = { [weak self] _ in
            self?.fruits = returnedItems
        }
         
        self.addOperarion(operation: operation)
    }
    
    private func addOperarion(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
}
