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
        resolver.register { ChatCache() }.scope(.application)
        resolver.register { AddNewChatCache() }.scope(.application)
        resolver.register { GroupsCache() }.scope(.application)
        resolver.register { ChatsCache() }.scope(.application)
        resolver.register { TrainingsCache() }.scope(.application)
        resolver.register { SettingsCache() }.scope(.application)
        resolver.register { MainCache() }.scope(.application)

        resolver.register { LoginCache(key: SettingsKey(keyName: "userCache", secure: false)) }.scope(.application)
        resolver.register { TokenCache() }.scope(.application)

        resolver.register { OnboardingCache() }.scope(.application)
    }

    private static func registerDomainClasses() {
        registerChatDomain()
        registerAddNewChatDomain()
        registerGroupsDomain()
        registerChatsDomain()
        registerTrainingsDomain()
        registerSettingsDomain()
        registerMainDomain()
        registerLoginDomain()
        registerOnboardingDomain()
    }
}

extension DependencyInjector {
    private static func registerChatDomain() {
        register(domain: ChatStore(), implements: ChatStoreProtocol.self)
        register(domain: ChatAction(), implements: ChatActionProtocol.self)

        resolver.register { ChatDomain() }.scope(.application)
    }

    private static func registerAddNewChatDomain() {
        register(domain: AddNewChatStore(), implements: AddNewChatStoreProtocol.self)
        register(domain: AddNewChatAction(), implements: AddNewChatActionProtocol.self)

        resolver.register { AddNewChatDomain() }.scope(.application)
    }

    private static func registerGroupsDomain() {
        register(domain: GroupsStore(), implements: GroupsStoreProtocol.self)
        register(domain: GroupsAction(), implements: GroupsActionProtocol.self)

        resolver.register { GroupsDomain() }.scope(.application)
    }

    private static func registerChatsDomain() {
        register(domain: ChatsStore(), implements: ChatsStoreProtocol.self)
        register(domain: ChatsAction(), implements: ChatsActionProtocol.self)

        resolver.register { ChatsDomain() }.scope(.application)
    }

    private static func registerTrainingsDomain() {
        register(domain: TrainingsStore(), implements: TrainingsStoreProtocol.self)
        register(domain: TrainingsAction(), implements: TrainingsActionProtocol.self)

        resolver.register { TrainingsDomain() }.scope(.application)
    }

    private static func registerSettingsDomain() {
        register(domain: SettingsStore(), implements: SettingsStoreProtocol.self)
        register(domain: SettingsAction(), implements: SettingsActionProtocol.self)

        resolver.register { SettingsDomain() }.scope(.application)
    }

    private static func registerMainDomain() {
        register(domain: MainStore(), implements: MainStoreProtocol.self)
        register(domain: MainAction(), implements: MainActionProtocol.self)

        resolver.register { MainDomain() }.scope(.application)
    }

    private static func registerLoginDomain() {
        register(domain: LoginStore(), implements: LoginStoreProtocol.self)
        register(domain: LoginAction(), implements: LoginActionProtocol.self)

        resolver.register { LoginDomain() }.scope(.application)
    }

    private static func registerOnboardingDomain() {
        register(domain: OnboardingStore(), implements: OnboardingStoreProtocol.self)
        register(domain: OnboardingAction(), implements: OnboardingActionProtocol.self)

        resolver.register { OnboardingDomain() }.scope(.application)
    }
}

extension DependencyInjector {
    private static func register<T, S>(domain: @autoclosure @escaping () -> T, implements implemented: S.Type) {
        resolver.register { domain() }.implements(implemented).scope(.application)
    }
}
