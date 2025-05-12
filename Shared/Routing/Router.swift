//
//  Router.swift
//  SpecialtyCoffeeApp
//
//  Created by Jhon Lopez on 5/6/25.
//
import SwiftUI

protocol Router: AnyObject {
    var navigationContext: NavigationContext { get }
    func navigate(to route: Route)
}

protocol Route {
    
}

protocol NavigationContext {
    func setInitialView<T: View>(view: T)
    func push<T: View>(view: T, animated: Bool)
//    func pop(animated: Bool)
    func present<T: View>(view: T, animated: Bool)
//    func dismiss(animated: Bool)
}
