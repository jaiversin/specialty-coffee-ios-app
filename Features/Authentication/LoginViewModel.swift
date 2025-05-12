import Combine
import UIKit

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var token: String?

    private var cancellables = Set<AnyCancellable>()
    private let apiClient: APIClient

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    func login() {
        isLoading = true
        errorMessage = nil

        apiClient.request(Endpoint.login(email: username, password: password))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] (response: LoggedInUser) in
                if response.token != "" {
                    TokenManager.shared.token = response.token
                }
            })
            .store(in: &cancellables)
    }

    func register(email: String, password: String) {
        isLoading = true
        errorMessage = nil

        let registrationData = ["email": email, "password": password]

        apiClient.request(Endpoint.register(userData: registrationData))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] (response: [String: String]) in
                self?.token = response["token"] ?? ""
            })
            .store(in: &cancellables)
    }
}

struct LoginResponse: Decodable {
    let token: String
}

struct RegisterResponse: Decodable {
    let token: String
}
