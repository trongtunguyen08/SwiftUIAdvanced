//
//  CombineViewModel.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 8/7/24.
//

import Foundation
import Combine


class CombineViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []
    @Published var error: String = ""
    
    let dataService = CombineDataService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
//        dataService
//            .$basicPublisher
//            .currentPublisherValue
//            .passthroughPublisher
        // Sequence Operations
        /*
//            .first(where: { value in
//                return value > 4
//            })
//            .tryFirst(where: { value in
//                if value == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                
//                return value > 4
//            })
//            .last()
//            .last(where: { $0 > 4})
//            .tryLast(where: { value in
//                if value == 13 {
//                    throw URLError(.badServerResponse)
//                }
//                return value > 1
//            })
//            .dropFirst()
//            .drop(while: { $0 < 4})
//            .tryDrop(while: { value in
//                if value == 15 {
//                    throw URLError(.badServerResponse)
//                }
//                return value < 6
//            })
//            .prefix(4)
//            .prefix(while: { $0 < 5 })
//            .tryPrefix(while: )
//            .output(at: 5)
            .output(in: 2..<4)
         */
        
        // Mathematic Operations
        /*
//            .max()
//            .max(by: { value1, value2 in
//                return value1 < value2
//            })
//            .tryMax(by: )
//            .min()
//            .min(by: )
//            .tryMin(by: )
         */
        
        // Filter / Reducing Operations
        /*
//            .map({ String($0) })
//            .tryMap({ value in
//                if value == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return String(value)
//            })
//            .compactMap({ value in
//                if value == 5 {
//                    return nil
//                }
//                return String(value)
//            })
//            .tryCompactMap()
//            .filter({ ($0 > 3) && ($0 < 7) })
//            .tryFilter()
//            .removeDuplicates()
//            .removeDuplicates(by: { value1, value2 in
//                return value1 == value2
//            })
//            .tryRemoveDuplicates(by: )
//            .replaceNil(with: 5)
//            .replaceEmpty(with: [])
//            .replaceError(with: "DEFAULT VALUE")
//            .scan(0, { existingValue, newValue in
//                return existingValue + newValue
//            })
//            .scan(0, { $0 + $1 })
//            .scan(0, +)
//            .tryScan(, )
//            .reduce(0, { existingValue, newValue in
//                return existingValue + newValue
//            })
//            .reduce(0, +)
//            .collect()
//            .collect(3)
            .allSatisfy({ $0 > 5 })
         */
        
        // Timing Operations
        /*
//            .debounce(for: 1.0, scheduler: DispatchQueue.main)
//            .delay(for: 3, scheduler: DispatchQueue.main)
//            .throttle(for: 10, scheduler: DispatchQueue.main, latest: true)
//            .retry(3)
//            .timeout(5, scheduler: DispatchQueue.main)
        */
        
        // Multiple Publishers / Subscribers
        /*
//            .combineLatest(dataService.boolPublisher, dataService.intPublisher)
//            .compactMap({ (int, bool) in
//                if bool {
//                    return String(int)
//                }
//                return nil
//            })
//            .compactMap({ (int1, bool, int2) in
//                if bool {
//                    return String(int1)
//                }
//                return "N/A"
//            })
//            .merge(with: dataService.intPublisher)
//            .zip(dataService.boolPublisher, dataService.intPublisher)
//            .map({ tuple in
//                return String(tuple.0) + tuple.1.description + String(tuple.2)
//            })
//            .tryMap({ value in
//                if value == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return value
//            })
//            .catch({ _ in
//                return self.dataService.intPublisher
//            })
        */
        
        let sharedPublisher = dataService
            .passthroughPublisher
            .share()
            .multicast {
                PassthroughSubject<Int,Error>()
            }
        
        sharedPublisher
            .map({ String($0) })
            .sink { complition in
                switch complition {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "WE HAVE ERROR: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)
        
        sharedPublisher
            .map({ $0 > 4 ? true : false })
            .sink { complition in
                switch complition {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "WE HAVE ERROR: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.dataBools.append(returnedValue)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            sharedPublisher
                .connect()
                .store(in: &cancellables)
        }
    }
}
