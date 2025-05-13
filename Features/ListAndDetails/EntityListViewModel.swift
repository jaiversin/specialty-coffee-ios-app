//
//  EntityListViewModel.swift
//  SpecialtyCoffeeApp
//
//  Created by Jhon Lopez on 5/12/25.
//

import Combine
import SwiftUI

class EntityListViewModel<T: Decodable>: ObservableObject {
    @Published var result = PageableResult<T>()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    @Injected(\.viewModel.apiClient)
    private var apiClient: APIClient
    
    var router: CoffeesRouter?

    func fetchCoffees() {
        isLoading = true
        errorMessage = nil

        if let endpoint = Endpoint.listEndpoint(for: T.self) {
            apiClient.request(endpoint)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case let .failure(error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] fetchingResult in
                    self?.result = fetchingResult
                })
                .store(in: &cancellables)
        }
    }
}
