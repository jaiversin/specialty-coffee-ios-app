import Combine
import SwiftUI

// TODO: Create a generic list view - detail view
class CoffeesListViewModel: ObservableObject {
    @Published var result = PageableResult<Coffee>()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    @Injected(\.viewModel.apiClient)
    private var apiClient: APIClient
    
    var router: CoffeesRouter?

    func fetchCoffees() {
        isLoading = true
        errorMessage = nil

        apiClient.request(Endpoint.getCoffees)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] coffeesResult in
                self?.result = coffeesResult
            })
            .store(in: &cancellables)
    }
}


// Leaving this here just for educational purposes

//class ExampleCoffeesListViewModel: ObservableObject {
//    @Published var result = PageableResult<Coffee>()
//    @Published var coffees = [Coffee]()
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String?
//    
//    private var cancellables = Set<AnyCancellable>()
//    @Injected(\.viewModel.apiClient)
//    private var apiClient: APIClient
//    
//    var router: CoffeesRouter?
//
//    func fetchCoffees() {
//        isLoading = true
//        errorMessage = nil
//
//        apiClient.request(Endpoint.getCoffees)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//                self?.isLoading = false
//                if case let .failure(error) = completion {
//                    self?.errorMessage = error.localizedDescription
//                }
//            }, receiveValue: { [weak self] (coffeesResult: DynamicResponse) in
//                var coffeesResultArray: [Coffee] = []
//                
//                // Access dynamic data
//                if let coffees = coffeesResult.data["coffees"]?.value as? [[String: Any]] {
//                    for coffee in coffees {
//                        let roaster = coffee["roaster"] as? [String: Any]
//                        coffeesResultArray.append(Coffee(id: coffee["_id"] as? String ?? "",
//                                           name: coffee["name"] as? String ?? "",
//                                           roaster: Roaster(id: roaster?["_id"] as? String ?? "",
//                                                            name: roaster?["name"] as? String ?? "",
//                                                            location: roaster?["location"] as? String ?? ""),
//                                           origin: coffee["origin"] as? String ?? "",
//                                           roastLevel: coffee["roastLevel"] as? String ?? "",
//                                           description: coffee["description"] as? String ?? "",
//                                           price: coffee["price"] as? Double ?? 0.0,
//                                           availableQuantity: coffee["availableQuantity"] as? Int ?? 0))
//                    }
//                }
//
//                self?.result.entries = coffeesResultArray
//            })
//            .store(in: &cancellables)
//    }
//}
//
//
//
//struct DynamicResponse: Decodable {
//    let data: [String: AnyCodable]
//    let total: Int
//    let page: Int
//    let totalPages: Int
//
//    enum CodingKeys: String, CodingKey {
//        case total, page, totalPages
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        total = try container.decode(Int.self, forKey: .total)
//        page = try container.decode(Int.self, forKey: .page)
//        totalPages = try container.decode(Int.self, forKey: .totalPages)
//
//        // Decode the dynamic data
//        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
//        var tempData: [String: AnyCodable] = [:]
//        for key in dynamicContainer.allKeys {
//            tempData[key.stringValue] = try dynamicContainer.decode(AnyCodable.self, forKey: key)
//        }
//        data = tempData
//    }
//}
//
//struct DynamicKey: CodingKey {
//    var stringValue: String
//    var intValue: Int?
//
//    init?(stringValue: String) {
//        self.stringValue = stringValue
//    }
//
//    init?(intValue: Int) {
//        return nil
//    }
//}
