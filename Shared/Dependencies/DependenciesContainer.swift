//
//  DependenciesContainer.swift
//  SpecialtyCoffeeApp
//
//  Created by Jhon Lopez on 5/6/25.
//


import Foundation

final class DependenciesContainer {
    struct ViewModelDependencies {
        // Services
        
        // Coordinators
        
        // API Client - Temporary as this will be replaced by services
        let apiClient: APIClient
    }
    
    private(set) var viewModel: ViewModelDependencies
    
    internal init(viewModel: ViewModelDependencies) {
        self.viewModel = viewModel
    }
}

extension DependenciesContainer {
    static var assembly: DependenciesContainer = {
        return DependenciesContainer.assembleRealApp()
    }()
    
    static func assembleRealApp() -> DependenciesContainer {
        let apiClient = APIClient()
        let viewModelDependencies = ViewModelDependencies(apiClient: apiClient)
        
        return .init(viewModel: viewModelDependencies)
    }
}
