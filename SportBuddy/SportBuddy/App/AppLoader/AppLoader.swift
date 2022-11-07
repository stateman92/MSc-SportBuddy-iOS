//
//  AppLoader.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

enum AppLoader {
    // MARK: Nested types

    enum Environment: String {
        case mock
        case dev
        case prod
    }

    struct AppConfig: Decodable {
        // MARK: Properties

        let serverUrl: String
    }

    // MARK: Properties

    @LazyInjected private static var loginDomain: LoginDomainImpl
    @LazyInjected private static var navigatorService: NavigatorService
    @LazyInjected private static var translatorService: TranslatorService
    private static let appConfig: AppConfig = {
        guard let appConfig = appConfigs.first(where: { $0.key == environment.rawValue })?.value else {
            preconditionFailure("AppConfig cannot load for environment \(environment.rawValue)!")
        }
        return appConfig
    }()
    private static var window: UIWindow?
    private static var cancellables = Cancellables()
}

// MARK: - Public methods

extension AppLoader {
    static func setup(window: UIWindow?) {
        self.window = window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        setupLogics()
        setupUI()
    }
}

// MARK: - Setups

extension AppLoader {
    private static func setupUI() {
        guard let window else { return }
        navigatorService.reset(to: StartupScreen.self)
        navigatorService.becameRoot(in: window)
        window.makeKeyAndVisible()

        DeferredFuture { (promise: @escaping (Result<Void, Never>) -> Void) -> Void in
            // if needed, here can be done some heavy work before the app starts while the users is watching the splash
            navigatorService.reset(to: OnboardingScreen.self)
            promise(.success(()))
        }
        .sink()
        .store(in: &cancellables)
    }
}

// MARK: - Helpers

extension AppLoader {
    private static func setupLogics() {
        setupDependencies()
        setupAPI()
        setupTokenObservation()
    }

    private static func setupDependencies() {
        DependencyInjector.registerDependencies()
        DependencyInjector.resolver.register { StartupScreen() }.scope(.unique)

        let translatorService: TranslatorService = DependencyInjector.resolve()
        translatorService.start()
    }

    private static func setupAPI() {
        OpenAPIClientAPI.basePath = appConfig.serverUrl
        OpenAPIClientAPI.apiResponseQueue = .global(qos: .userInitiated)
        OpenAPIClientAPI.requestBuilderFactory = TokenizableRequestBuilderFactory()
    }

    private static func setupTokenObservation() {
        NotificationCenter.addObserver(forName: .name(UIApplication.willEnterForegroundNotification)) {
            loginDomain
                .action
                .refreshToken()
                .sink(receiveError: { _ in navigatorService.reset(to: OnboardingScreen.self) })
                .store(in: &cancellables)
        }
    }

    static var environment: Environment {
#if MOCK
        .mock
#elseif DEV
        .dev
#else
        .prod
#endif
    }

    static var version: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    private static var appConfigs: [String: AppConfig] {
        guard let data = Bundle.main.data(forResource: Constants.Files.configuration,
                                          withExtension: Constants.Extensions.plist.rawValue),
              let appConfigs = try? PropertyListDecoder().decode([String: AppConfig].self, from: data) else {
            preconditionFailure("AppConfig plist file cannot load!")
        }
        return appConfigs
    }
}
