import Foundation
import Combine

class APIClient {
    private let baseURL = URL(string: "http://localhost:3000/api")!
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: "\(baseURL)\(endpoint.path)") else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        return session.dataTaskPublisher(for: request)
            .tryMap{ data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                                    200..<300 ~= httpResponse.statusCode else {
                                        switch (response as! HTTPURLResponse).statusCode {
                                        case 401:
                                            throw APIError.invalidToken
                                        default:
                                            throw APIError.httpError("\(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                                        }
                                }
                                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { APIError.map($0) }
            .eraseToAnyPublisher()
    }
}
