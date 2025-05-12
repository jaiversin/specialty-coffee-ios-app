import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case invalidToken
    case networkError(Error)
    case httpError(String)

    static func map(_ error: Error) -> APIError {
        debugPrint("APIError: ", error)
        guard (error as? DecodingError) == nil else {
            return .decodingError
        }
        
        if let error = error as? APIError, case .invalidToken = error {
            TokenManager.shared.clearToken()
        }
        
        return .networkError(error)
    }
}
