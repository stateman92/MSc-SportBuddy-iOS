//
//  LazyInjected.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

/// A thin layer between the application and the DI library (Resolver). The dependency will be resolver lazily (at the first time you want to use).
@propertyWrapper struct LazyInjected<Service> {
    private lazy var service: Service = DependencyInjector.resolve()

    /// The injected object.
    var wrappedValue: Service {
        mutating get { service }
        mutating set { service = newValue }
    }

    /// The property wrapper.
    var projectedValue: Self {
        get { self }
        mutating set { self = newValue }
    }
}
