//
//  Domain+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

extension DependencyInjector {
    /// Register all the domain-related dependencies of the application.
    static func registerDomains() {
        registerCaches()
        registerDomainClasses()
    }
}

extension DependencyInjector {
    private static func registerCaches() {
        resolver.register { UserCache() }
        resolver.register { TokenCache() }
        resolver.register { GroupCache() }
        resolver.register { ChatCache() }
        resolver.register { TrainingCache() }
    }

    private static func registerDomainClasses() {
        register(domain: UserDomain(), implements: UserDomainProtocol.self)
        register(domain: GroupDomain(), implements: GroupDomainProtocol.self)
        register(domain: ChatDomain(), implements: ChatDomainProtocol.self)
        register(domain: TrainingDomain(), implements: TrainingDomainProtocol.self)
    }
}

extension DependencyInjector {
    private static func register<T, S>(domain: @autoclosure @escaping () -> T, implements implemented: S.Type) {
        resolver.register { domain() }.implements(implemented).scope(.application)
    }
}
