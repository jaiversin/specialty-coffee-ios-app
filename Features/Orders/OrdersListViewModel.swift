import Combine
import UIKit

class OrdersListViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    @Injected(\.viewModel.apiClient)
    private var apiClient: APIClient

    func fetchOrders() {
        isLoading = true
        errorMessage = nil

        apiClient.request(Endpoint.getOrders)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] orders in
                self?.orders = orders
            })
            .store(in: &cancellables)
    }
}
