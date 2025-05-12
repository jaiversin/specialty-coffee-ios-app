//
//  NavigationController.swift
//  SpecialtyCoffeeApp
//
//  Created by Jhon Lopez on 5/7/25.
//

import SwiftUI

final class NavigationController: UINavigationController, NavigationContext {
    
    func setInitialView<T>(view: T) where T : View {
        let vc = UIHostingController(rootView: view)
        viewControllers = [vc]
    }
    
    func push<T>(view: T, animated: Bool) where T : View {
        let vc = UIHostingController(rootView: view)
        pushViewController(vc, animated: animated)
    }
    
    func present<T>(view: T, animated: Bool) where T : View {
        let vc = UIHostingController(rootView: view)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .automatic
        present(vc, animated: animated)
    }
    
}
