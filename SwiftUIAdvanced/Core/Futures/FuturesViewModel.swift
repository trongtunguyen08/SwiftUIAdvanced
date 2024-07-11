//
//  FuturesViewModel.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 9/7/24.
//

import Foundation
import Combine
// download with Combine
// download with @escaping closure
// convert @escaping closure to Combine

class FuturesViewModel: ObservableObject {
    @Published var title: String = "Starting title..."
    let url = URL(string: "https://www.google.com.vn")!
    var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    private func download() {
//        getCombinePublisher()
        getFuturePublisher()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)
        
//        getEscapingClosure { [weak self] value, error in
//            self?.title = value
//        }
    }
    
    func getCombinePublisher() -> AnyPublisher<String,Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .tryMap({ _ in
                return "N/A "
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(complitionHandler: @escaping (_ value: String, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            complitionHandler("New Value", nil)
        }
        .resume()
    }
    
    func getFuturePublisher() -> Future<String,Error> {
        Future { promise in
            self.getEscapingClosure { returnedValue, error in
                if let error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnedValue))
                }
            }
        }
    }
    
    func doSonething(complitionHandler: @escaping(_ value: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            complitionHandler("NEW TITLE HERE!")
        }
    }
    
    func doSomethingInTheFuture() -> Future<String,Never> {
        Future { promise in 
            self.doSonething { returnedValue in
                promise(.success(returnedValue))
            }
        }
    }
}
