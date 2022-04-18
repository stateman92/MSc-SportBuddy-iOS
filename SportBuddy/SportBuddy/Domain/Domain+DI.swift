//
//  Domain+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

extension DependencyInjector {
    /// Register all the domain-related dependencies of the application.
    static func registerDomains() {
        register(domain: UserDomain(), cache: UserCache(), implements: UserDomainProtocol.self)
        register(domain: GroupDomain(), cache: GroupCache(), implements: GroupDomainProtocol.self)
        register(domain: ChatDomain(), cache: ChatCache(), implements: ChatDomainProtocol.self)
        register(domain: TrainingDomain(), cache: TrainingCache(), implements: TrainingDomainProtocol.self)
    }
}

extension DependencyInjector {
    private static func register<T, S, R>(domain: @autoclosure @escaping () -> T,
                                          cache: @autoclosure @escaping () -> Cache<S>,
                                          implements implemented: R.Type) {
        resolver.register { domain() }.implements(implemented).scope(.application)
        resolver.register { cache() }
    }
}
