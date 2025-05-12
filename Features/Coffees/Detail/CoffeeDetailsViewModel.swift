import Foundation

class CoffeeDetailsViewModel: ObservableObject {
    @Published var coffee: Coffee

    init(coffee: Coffee) {
        self.coffee = coffee
    }
}