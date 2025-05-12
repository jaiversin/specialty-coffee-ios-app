import SwiftUI

struct OrdersListView: View {
    @ObservedObject var viewModel: OrdersListViewModel

    var body: some View {
        List(viewModel.orders) { order in
            VStack(alignment: .leading) {
                Text("Order ID: \(order.id)")
                    .font(.headline)
                Text("Total: $\(order.total, specifier: "%.2f")")
                    .font(.subheadline)
                Text("Status: \(order.status)")
                    .font(.subheadline)
            }
        }
        .onAppear {
            viewModel.fetchOrders()
        }
        .navigationTitle("Orders")
    }
}