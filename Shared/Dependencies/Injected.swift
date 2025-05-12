//
//  Injected.swift
//  SpecialtyCoffeeApp
//
//  Created by Jhon Lopez on 5/6/25.
//


import Foundation

@propertyWrapper
public struct Injected<T> {

    private let keyPath: KeyPath<DependenciesContainer, T>
    
    public var wrappedValue: T {
        DependenciesContainer.assembly[keyPath: keyPath]
    }
    
    init(_ keyPath: KeyPath<DependenciesContainer, T>) {
        self.keyPath = keyPath
    }
}