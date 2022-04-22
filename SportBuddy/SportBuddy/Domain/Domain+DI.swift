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
        registerUserDomain()
        registerGroupDomain()
        registerChatDomain()
        registerTrainingDomain()
    }
}

extension DependencyInjector {
    private static func registerUserDomain() {
        register(domain: UserStore(), implements: UserStoreProtocol.self)
        register(domain: UserAction(), implements: UserActionProtocol.self)
    }

    private static func registerGroupDomain() {
        register(domain: GroupStore(), implements: GroupStoreProtocol.self)
        register(domain: GroupAction(), implements: GroupActionProtocol.self)
    }

    private static func registerChatDomain() {
        register(domain: ChatStore(), implements: ChatStoreProtocol.self)
        register(domain: ChatAction(), implements: ChatActionProtocol.self)
    }

    private static func registerTrainingDomain() {
        register(domain: TrainingStore(), implements: TrainingStoreProtocol.self)
        register(domain: TrainingAction(), implements: TrainingActionProtocol.self)
    }
}

extension DependencyInjector {
    private static func register<T, S>(domain: @autoclosure @escaping () -> T, implements implemented: S.Type) {
        resolver.register { domain() }.implements(implemented).scope(.application)
    }
}
