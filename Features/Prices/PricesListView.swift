import SwiftUI

struct PricesListView: View {
    @ObservedObject var viewModel: PricesListViewModel

    var body: some View {
        List(viewModel.prices) { price in
            VStack(alignment: .leading) {
                Text("Coffee ID: \(price.coffeeId)")
                    .font(.headline)
                Text("Shop ID: \(price.shopId)")
                    .font(.subheadline)
                Text("Price: $\(price.amount, specifier: "%.2f")")
                    .font(.subheadline)
            }
        }
        .onAppear {
            viewModel.fetchPrices()
        }
        .navigationTitle("Prices")
    }
}