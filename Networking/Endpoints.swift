import Foundation

enum Endpoint {
    // Auth
    case login(email: String, password: String)
    case register(userData: [String: Any])
    
    // Profile
    case getProfile
    case updateProfile(userData: [String: Any])
    
    // Orders
    case getOrders
    case getOrder(id: String)
    case createOrder(orderData: [String: Any])
    case updateOrderStatus(id: String, status: String)
    case deleteOrder(id: String)
    
    // Shops
    case getShops
    case getShop(id: String)
    case createShop(shopData: [String: Any])
    case updateShop(id: String, shopData: [String: Any])
    case deleteShop(id: String)
    case getShopsByLocation(location: String)
    
    // Roasters
    case getRoasters
    case getRoaster(id: String)
    case createRoaster(roasterData: [String: Any])
    case updateRoaster(id: String, roasterData: [String: Any])
    case deleteRoaster(id: String)
    case getRoastersByLocation(location: String)
    
    // Coffees
    case getCoffees
    case getCoffee(id: String)
    case createCoffee(coffeeData: [String: Any])
    case updateCoffee(id: String, coffeeData: [String: Any])
    case deleteCoffee(id: String)
    case getRoasterCoffees(roasterId: String)
    
    // Prices
    case getCoffeePrices(coffeeId: String)
    case getShopPrices(shopId: String)
    case getCurrentPrice(coffeeId: String, shopId: String)
    case getPriceHistory(coffeeId: String, shopId: String)
    case createPrice(priceData: [String: Any])
    case updatePrice(id: String, priceData: [String: Any])
    case deletePrice(id: String)

    var path: String {
        switch self {
        // Auth
        case .login: return "/users/login"
        case .register: return "/users/register"
            
        // Profile
        case .getProfile: return "/profile"
        case .updateProfile: return "/profile"
            
        // Orders
        case .getOrders: return "/orders"
        case .getOrder(let id): return "/orders/\(id)"
        case .createOrder: return "/orders"
        case .updateOrderStatus(let id, _): return "/orders/\(id)/status"
        case .deleteOrder(let id): return "/orders/\(id)"
            
        // Shops
        case .getShops: return "/shops"
        case .getShop(let id): return "/shops/\(id)"
        case .createShop: return "/shops"
        case .updateShop(let id, _): return "/shops/\(id)"
        case .deleteShop(let id): return "/shops/\(id)"
        case .getShopsByLocation(let location): return "/shops/search/location/\(location)"
            
        // Roasters
        case .getRoasters: return "/roasters"
        case .getRoaster(let id): return "/roasters/\(id)"
        case .createRoaster: return "/roasters"
        case .updateRoaster(let id, _): return "/roasters/\(id)"
        case .deleteRoaster(let id): return "/roasters/\(id)"
        case .getRoastersByLocation(let location): return "/roasters/search/location/\(location)"
            
        // Coffees
        case .getCoffees: return "/coffees"
        case .getCoffee(let id): return "/coffees/\(id)"
        case .createCoffee: return "/coffees"
        case .updateCoffee(let id, _): return "/coffees/\(id)"
        case .deleteCoffee(let id): return "/coffees/\(id)"
        case .getRoasterCoffees(let roasterId): return "/coffees/roaster/\(roasterId)"
            
        // Prices
        case .getCoffeePrices(let coffeeId): return "/prices/coffee/\(coffeeId)"
        case .getShopPrices(let shopId): return "/prices/shop/\(shopId)"
        case .getCurrentPrice(let coffeeId, let shopId): return "/prices/coffee/\(coffeeId)/shop/\(shopId)"
        case .getPriceHistory(let coffeeId, let shopId): return "/prices/coffee/\(coffeeId)/shop/\(shopId)/history"
        case .createPrice: return "/prices"
        case .updatePrice(let id, _): return "/prices/\(id)"
        case .deletePrice(let id): return "/prices/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProfile, .getOrders, .getOrder, .getShops, .getShop, .getRoasters, .getRoaster,
             .getCoffees, .getCoffee, .getRoasterCoffees, .getCoffeePrices, .getShopPrices,
             .getCurrentPrice, .getPriceHistory, .getShopsByLocation, .getRoastersByLocation:
            return .get
        case .login, .register, .createOrder, .createShop, .createRoaster, .createCoffee, .createPrice:
            return .post
        case .updateProfile, .updateShop, .updateRoaster, .updateCoffee, .updatePrice:
            return .put
        case .updateOrderStatus:
            return .patch
        case .deleteOrder, .deleteShop, .deleteRoaster, .deleteCoffee, .deletePrice:
            return .delete
        }
    }
    
    var headers: [String: String] {
        var headers = ["Content-Type": "application/json"]
        // Add Authorization header for protected endpoints
        switch self {
        case .login, .register:
            break
        default:
            if let token = TokenManager.shared.token {
                headers["Authorization"] = "Bearer \(token)"
            }
        }
        return headers
    }
    
    var body: [String: Any]? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]
        case .register(let userData):
            return userData
        case .updateProfile(let userData):
            return userData
        case .createOrder(let orderData):
            return orderData
        case .updateOrderStatus(_, let status):
            return ["status": status]
        case .createShop(let shopData), .updateShop(_, let shopData):
            return shopData
        case .createRoaster(let roasterData), .updateRoaster(_, let roasterData):
            return roasterData
        case .createCoffee(let coffeeData), .updateCoffee(_, let coffeeData):
            return coffeeData
        case .createPrice(let priceData), .updatePrice(_, let priceData):
            return priceData
        default:
            return nil
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
