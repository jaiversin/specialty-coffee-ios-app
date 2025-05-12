import SwiftUI

struct RoastersListView: View {
    @ObservedObject var viewModel: RoastersListViewModel

    var body: some View {
        List(viewModel.result.entries) { roaster in
            VStack(alignment: .leading) {
                Text(roaster.name)
                    .font(.headline)
                Text(roaster.location)
                    .font(.subheadline)
            }
        }
        .onAppear {
            viewModel.fetchRoasters()
        }
        .navigationTitle("Roasters")
    }
}
