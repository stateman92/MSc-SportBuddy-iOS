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
        registerLiveFeedDomain()
        registerChatsDomain()
        registerTrainingsDomain()
        registerSettingsDomain()
        registerMainDomain()
        registerLoginDomain()
        registerOnboardingDomain()
        registerExerciseDomain()
    }
}

extension DependencyInjector {
    private static func registerChatDomain() {
        register(domain: ChatStoreImpl(), mock: MockChatStore(), implements: ChatStore.self)
        register(domain: ChatActionImpl(), mock: MockChatAction(), implements: ChatAction.self)

        resolver.register { ChatDomainImpl() }
    }

    private static func registerAddNewChatDomain() {
        register(domain: AddNewChatStoreImpl(), mock: MockAddNewChatStore(), implements: AddNewChatStore.self)
        register(domain: AddNewChatActionImpl(), mock: MockAddNewChatAction(), implements: AddNewChatAction.self)

        resolver.register { AddNewChatDomainImpl() }
    }

    private static func registerLiveFeedDomain() {
        register(domain: LiveFeedStoreImpl(), mock: MockLiveFeedStore(), implements: LiveFeedStore.self)
        register(domain: LiveFeedActionImpl(), mock: MockLiveFeedAction(), implements: LiveFeedAction.self)

        resolver.register { LiveFeedDomainImpl() }
    }

    private static func registerChatsDomain() {
        register(domain: ChatsStoreImpl(), mock: MockChatsStore(), implements: ChatsStore.self)
        register(domain: ChatsActionImpl(), mock: MockChatsAction(), implements: ChatsAction.self)

        resolver.register { ChatsDomainImpl() }
    }

    private static func registerTrainingsDomain() {
        register(domain: TrainingsStoreImpl(), mock: MockTrainingsStore(), implements: TrainingsStore.self)
        register(domain: TrainingsActionImpl(), mock: MockTrainingsAction(), implements: TrainingsAction.self)

        resolver.register { TrainingsDomainImpl() }
    }

    private static func registerSettingsDomain() {
        register(domain: SettingsStoreImpl(), mock: MockSettingsStore(), implements: SettingsStore.self)
        register(domain: SettingsActionImpl(), mock: MockSettingsAction(), implements: SettingsAction.self)

        resolver.register { SettingsDomainImpl() }
    }

    private static func registerMainDomain() {
        register(domain: MainStoreImpl(), mock: MockMainStore(), implements: MainStore.self)
        register(domain: MainActionImpl(), mock: MockMainAction(), implements: MainAction.self)

        resolver.register { MainDomainImpl() }
    }

    private static func registerLoginDomain() {
        register(domain: LoginStoreImpl(), mock: MockLoginStore(), implements: LoginStore.self)
        register(domain: LoginActionImpl(), mock: MockLoginAction(), implements: LoginAction.self)

        resolver.register { LoginDomainImpl() }
    }

    private static func registerOnboardingDomain() {
        register(domain: OnboardingStoreImpl(), mock: MockOnboardingStore(), implements: OnboardingStore.self)
        register(domain: OnboardingActionImpl(), mock: MockOnboardingAction(), implements: OnboardingAction.self)

        resolver.register { OnboardingDomainImpl() }
    }

    private static func registerExerciseDomain() {
        register(domain: ExerciseStoreImpl(), mock: MockExerciseStore(), implements: ExerciseStore.self)
        register(domain: ExerciseActionImpl(), mock: MockExerciseAction(), implements: ExerciseAction.self)

        resolver.register { ExerciseDomainImpl() }
    }
}

extension DependencyInjector {
    private static func register<DomainImpl, MockDomain, Domain>(domain: @autoclosure @escaping () -> DomainImpl,
                                                                 mock: @autoclosure @escaping () -> MockDomain,
                                                                 implements implemented: Domain.Type) {
#if MOCK
        resolver.register { mock() }.implements(implemented)
#else
        resolver.register { domain() }.implements(implemented)
#endif
    }
}
