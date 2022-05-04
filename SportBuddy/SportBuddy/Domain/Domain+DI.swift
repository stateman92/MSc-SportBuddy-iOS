//
//  Domain+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

extension DependencyInjector {
    /// Register all the domain-related dependencies of the application.
    static func registerDomain() {
        registerDomains()
    }
}

extension DependencyInjector {
    private static func registerDomains() {
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
        register(domain: ChatStore(), mock: MockChatStore(), implements: ChatStoreProtocol.self)
        register(domain: ChatAction(), mock: MockChatAction(), implements: ChatActionProtocol.self)

        resolver.register { ChatDomain() }
    }

    private static func registerAddNewChatDomain() {
        register(domain: AddNewChatStore(), mock: MockAddNewChatStore(), implements: AddNewChatStoreProtocol.self)
        register(domain: AddNewChatAction(), mock: MockAddNewChatAction(), implements: AddNewChatActionProtocol.self)

        resolver.register { AddNewChatDomain() }
    }

    private static func registerGroupsDomain() {
        register(domain: GroupsStore(), mock: MockGroupsStore(), implements: GroupsStoreProtocol.self)
        register(domain: GroupsAction(), mock: MockGroupsAction(), implements: GroupsActionProtocol.self)

        resolver.register { GroupsDomain() }
    }

    private static func registerChatsDomain() {
        register(domain: ChatsStore(), mock: MockChatsStore(), implements: ChatsStoreProtocol.self)
        register(domain: ChatsAction(), mock: MockChatsAction(), implements: ChatsActionProtocol.self)

        resolver.register { ChatsDomain() }
    }

    private static func registerTrainingsDomain() {
        register(domain: TrainingsStore(), mock: MockTrainingsStore(), implements: TrainingsStoreProtocol.self)
        register(domain: TrainingsAction(), mock: MockTrainingsAction(), implements: TrainingsActionProtocol.self)

        resolver.register { TrainingsDomain() }
    }

    private static func registerSettingsDomain() {
        register(domain: SettingsStore(), mock: MockSettingsStore(), implements: SettingsStoreProtocol.self)
        register(domain: SettingsAction(), mock: MockSettingsAction(), implements: SettingsActionProtocol.self)

        resolver.register { SettingsDomain() }
    }

    private static func registerMainDomain() {
        register(domain: MainStore(), mock: MockMainStore(), implements: MainStoreProtocol.self)
        register(domain: MainAction(), mock: MockMainAction(), implements: MainActionProtocol.self)

        resolver.register { MainDomain() }
    }

    private static func registerLoginDomain() {
        register(domain: LoginStore(), mock: MockLoginStore(), implements: LoginStoreProtocol.self)
        register(domain: LoginAction(), mock: MockLoginAction(), implements: LoginActionProtocol.self)

        resolver.register { LoginDomain() }
    }

    private static func registerOnboardingDomain() {
        register(domain: OnboardingStore(), mock: MockOnboardingStore(), implements: OnboardingStoreProtocol.self)
        register(domain: OnboardingAction(), mock: MockOnboardingAction(), implements: OnboardingActionProtocol.self)

        resolver.register { OnboardingDomain() }
    }
}

extension DependencyInjector {
    private static func register<Domain, MockDomain, DomainProtocol>(domain: @autoclosure @escaping () -> Domain,
                                                                     mock: @autoclosure @escaping () -> MockDomain,
                                                                     implements implemented: DomainProtocol.Type) {
        #if MOCK
        resolver.register { mock() }.implements(implemented)
        #else
        resolver.register { domain() }.implements(implemented)
        #endif
    }
}
