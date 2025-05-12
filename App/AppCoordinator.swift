import UIKit
import SwiftUI

class AppCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let tabBarController = UITabBarController()
        var tabs: [UIViewController] = []

        // Coffee List Tab
        let coffeeListViewModel = CoffeesListViewModel()
        let coffeeListView = CoffeesListView(viewModel: coffeeListViewModel)
        
        let coffeeNavController = NavigationController()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))

        
        coffeeNavController.setInitialView(view: coffeeListView)
        
        let coffeeRouter = CoffeesRouter(navigationContext: coffeeNavController)
        coffeeListViewModel.router = coffeeRouter
        
        coffeeNavController.tabBarItem = UITabBarItem(title: "Coffees", image: UIImage(systemName: "cup.and.saucer"), tag: 0)
        tabs.append(coffeeNavController)

        // Roasters List Tab
        let roasterListViewModel = RoastersListViewModel()
        let roastersListView = RoastersListView(viewModel: roasterListViewModel)
        let roastersListHostingController = UIHostingController(rootView: roastersListView)
        roastersListHostingController.tabBarItem = UITabBarItem(title: "Roasters", image: UIImage(systemName: "leaf"), tag: 1)
        tabs.append(roastersListHostingController)

        // Shops List Tab
        let shopsListViewModel = ShopsListViewModel()
        let shopsListView = ShopsListView(viewModel: shopsListViewModel)
        let shopsListHostingController = UIHostingController(rootView: shopsListView)
        shopsListHostingController.tabBarItem = UITabBarItem(title: "Shops", image: UIImage(systemName: "building.2"), tag: 2)
        tabs.append(shopsListHostingController)
        
        if TokenManager.shared.token != nil {
            let ordersListViewModel = OrdersListViewModel()
            let ordersListView = OrdersListView(viewModel: ordersListViewModel)
            let ordersListHostingController = UIHostingController(rootView: ordersListView)
            ordersListHostingController.tabBarItem = UITabBarItem(title: "Shops", image: UIImage(systemName: "text.badge.checkmark"), tag: 3)
            tabs.append(ordersListHostingController)
        }

        // Add view controllers to the tab bar
        tabBarController.viewControllers = tabs

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
