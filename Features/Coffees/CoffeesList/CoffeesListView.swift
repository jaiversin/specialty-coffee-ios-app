import SwiftUI

struct CoffeesListView: View {
    @ObservedObject var viewModel: EntityListViewModel<Coffee>
//    @State var coffees: [Coffee] = []

    var body: some View {
        VStack(alignment: .leading) {
            List(viewModel.result.entries) { (coffee: Coffee) in
                CoffeeItemRow(item: coffee)
                    .onTapGesture {
                        viewModel.router?.navigate(to: CoffeesRoute.detail(coffee))
                    }
            }
            .task {
                // Comment to test with preview
                viewModel.fetchCoffees()
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if TokenManager.shared.token == nil {
                            viewModel.router?.navigate(to: CoffeesRoute.login)
                        } else {
                            TokenManager.shared.clearToken()
                        }
                    } label: {
//                        if TokenManager.shared.token != nil {
                        Text(TokenManager.shared.token == nil ? "Login" : "Logout")
                    }
                    
                }
            }
            
            //        .onAppear {
            //            viewModel.fetchCoffees()
            //        }
            
        }
//        .padding()
        .navigationTitle("Coffees")
    }
}

#Preview {
    var vm = EntityListViewModel<Coffee>()
    vm.result.entries = [
        Coffee(id: "123",
               name: "Test Coffee",
               roaster: Roaster(
                id: "1234",
                name: "Roaster A",
                location: "Seattle"),
               origin: "Colombia - Huila",
               roastLevel: "Light - Medium",
               description: "This is the best coffee you can get in the country, by far, the best in this continent",
               price: 19,
               availableQuantity: 100),
        Coffee(id: "1234",
               name: "Test Coffee 2",
               roaster: Roaster(
                id: "1234",
                name: "Roaster A",
                location: "Seattle"),
               origin: "Colombia - Tolima",
               roastLevel: "Light",
               description: "This is the best coffee you can get in the country, by far, the best in this continent",
               price: 20,
               availableQuantity: 100)
    ]
    return CoffeesListView(viewModel: vm)
}
