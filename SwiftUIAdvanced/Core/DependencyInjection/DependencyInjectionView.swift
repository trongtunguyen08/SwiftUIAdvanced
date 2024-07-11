//
//  DependencyInjectionView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 5/7/24.
//

import SwiftUI
import Combine

struct PostModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServicePrototol {
    func getData() -> AnyPublisher<[PostModel], Error>
}

class StaggingDataService: DataServicePrototol {
    let mockedData: [PostModel] = [
        PostModel(userId: 1, id: 1, title: "A", body: "A"),
        PostModel(userId: 2, id: 2, title: "B", body: "B")
    ]
    
    func getData() -> AnyPublisher<[PostModel], any Error> {
        Just(mockedData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}

class ProductDataService: DataServicePrototol {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostModel], Error>  {
       URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) in
                data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class DependencyInjectionViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServicePrototol
    
    init(dataService: DataServicePrototol) {
        self.dataService = dataService
        getPost()
    }
    
    private func getPost() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)

    }
    
}


struct DependencyInjectionView: View {
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServicePrototol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        List(vm.posts) { post in
            Text(post.title)
        }
        .navigationTitle("Posts")
    }
}

#Preview {
    let dataService = ProductDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    return NavigationStack {
        DependencyInjectionView(dataService: dataService)
    }
}
