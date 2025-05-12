import Combine

class PricesListViewModel: ObservableObject {
    @Published var prices: [Price] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let apiClient: APIClient

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchPrices() {
        isLoading = true
        errorMessage = nil
        isLoading = false

//        apiClient.request(Endpoint.getPrices)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//                self?.isLoading = false
//                if case let .failure(error) = completion {
//                    self?.errorMessage = error.localizedDescription
//                }
//            }, receiveValue: { [weak self] prices in
//                self?.prices = prices
//            })
//            .store(in: &cancellables)
    }
}
