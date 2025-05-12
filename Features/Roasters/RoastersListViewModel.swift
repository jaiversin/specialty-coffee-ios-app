import Combine
import UIKit

class RoastersListViewModel: ObservableObject {
    @Published var result = PageableResult<Roaster>()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    @Injected(\.viewModel.apiClient)
    private var apiClient: APIClient

    func fetchRoasters() {
        isLoading = true
        errorMessage = nil

        apiClient.request(Endpoint.getRoasters)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] result in
                self?.result = result
            })
            .store(in: &cancellables)
    }
}
