import SwiftUI

struct CoffeeDetailsView: View {
    @ObservedObject var viewModel: CoffeeDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: "https://contenthandler-raleys.fieldera.com/prod/282196/1/0/0/80600624-Main.jpg")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(height: 200)
                }

                Text(viewModel.coffee.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Origin: \(viewModel.coffee.origin)")
                    .font(.headline)

                Text("Roast Level: \(viewModel.coffee.roastLevel)")
                    .font(.subheadline)

                if let description = viewModel.coffee.description {
                    Text(description)
                        .font(.body)
                        .padding(.top, 8)
                }

                Text("Price: $\(viewModel.coffee.price, specifier: "%.2f")")
                    .font(.headline)

                Text("Available Quantity: \(viewModel.coffee.availableQuantity)")
                    .font(.subheadline)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Roaster Details")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("Name: \(viewModel.coffee.roaster.name)")
                    Text("Location: \(viewModel.coffee.roaster.location)")
                }
                .padding(.top, 16)
            }
            .padding()
        }
        .navigationTitle("Coffee Details")
    }
}

#Preview {
    let coffee = Coffee(id: "123",
                        name: "Test Coffee",
                        roaster: Roaster(
                         id: "1234",
                         name: "Roaster A",
                         location: "Seattle"),
                        origin: "Colombia",
                        roastLevel: "Light",
                        description: "This is the best coffee you can get in the country, by far, the best in this continent",
                        price: 19,
                        availableQuantity: 100)
    let vm = CoffeeDetailsViewModel(coffee: coffee)
    
    CoffeeDetailsView(viewModel: vm)
}
