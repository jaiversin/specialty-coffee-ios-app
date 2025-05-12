import SwiftUI

struct ShopsListView: View {
    @ObservedObject var viewModel: ShopsListViewModel

    var body: some View {
        List(viewModel.result.entries) { shop in
            VStack(alignment: .leading) {
                Text(shop.name)
                    .font(.headline)
                Text(shop.location)
                    .font(.subheadline)
            }
        }
        .onAppear {
            viewModel.fetchShops()
        }
        .navigationTitle("Shops")
    }
}
