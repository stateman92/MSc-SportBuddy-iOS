//
//  SceneDelegate.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
//        let rootViewController = UIViewController()
//        rootViewController.view.backgroundColor = .systemBackground
//        func buttons(size: ButtonLabel.Size) -> UIStackView {
//            let arrangedViews = [ButtonLabel(text: "Primary button",
//                                             style: .primary,
//                                             size: size,
//                                             image: .none),
//                                 ButtonLabel(text: "Secondary button",
//                                             style: .secondary,
//                                             size: size,
//                                             image: .left(.image(.init(systemName: "pencil")!))),
//                                 ButtonLabel(text: "Tertiary button",
//                                             style: .tertiary,
//                                             size: size,
//                                             image: .right(.image(.init(systemName: "pencil")!))),
//                                 ButtonLabel(text: "Label button",
//                                             style: .label,
//                                             size: size,
//                                             image: .right(.activityIndicator))]
//            let stackView = UIStackView(arrangedSubviews: arrangedViews)
//            stackView.spacing = 16
//            return stackView
//        }
//        let stackView = UIStackView(arrangedSubviews: [buttons(size: .tiny),
//                                                       buttons(size: .small),
//                                                       buttons(size: .normal),
//                                                       buttons(size: .large),
//                                                       buttons(size: .huge)])
//        stackView.axis = .vertical
//        stackView.spacing = 16
//        stackView.alignment = .center
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        let scrollView = UIScrollView()
//        scrollView.delaysContentTouches = false
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        rootViewController.view.addSubview(scrollView)
//        scrollView.leadingAnchor.constraint(equalTo: rootViewController.view.leadingAnchor).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: rootViewController.view.trailingAnchor).isActive = true
//        scrollView.topAnchor.constraint(equalTo: rootViewController.view.topAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: rootViewController.view.bottomAnchor).isActive = true
//
//        scrollView.addSubview(stackView)
//        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8).isActive = true
//        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8).isActive = true
        window?.rootViewController = UINavigationController(rootViewController: OnboardingScreen())
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
