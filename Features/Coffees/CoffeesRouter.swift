//
//  CoffeesRouter.swift
//  SpecialtyCoffeeApp
//
//  Created by Jhon Lopez on 5/7/25.
//

import SwiftUI

enum CoffeesRoute: Route {
    case list
    case detail(Coffee)
    case login
}

final class CoffeesRouter: Router {
    var navigationContext: any NavigationContext
    
    init(navigationContext: any NavigationContext) {
        self.navigationContext = navigationContext
    }
    
    func navigate(to route: Route) {
        guard let route = route as? CoffeesRoute else { return }
        switch route {
        case .list:
            let coffeeListViewModel = EntityListViewModel<Coffee>()
            let coffeeListView = CoffeesListView(viewModel: coffeeListViewModel)
            navigationContext.setInitialView(view: coffeeListView)
        case .detail(let coffee):
            let coffeeDetailVM = CoffeeDetailsViewModel(coffee: coffee)
            let coffeeDetailView = CoffeeDetailsView(viewModel: coffeeDetailVM)
            navigationContext.push(view: coffeeDetailView, animated: true)
        case .login:
            let viewModel = LoginViewModel()
            let loginView = LoginView(viewModel: viewModel)
            navigationContext.present(view: loginView, animated: true)
        }
    }
}
