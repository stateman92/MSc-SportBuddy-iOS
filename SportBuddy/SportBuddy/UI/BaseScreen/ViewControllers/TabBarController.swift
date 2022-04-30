//
//  TabBarController.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

import UIKit

class TabBarController: UITabBarController {
    override var title: String? {
        didSet {
            tabBarItem.title = title
        }
    }

    // MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
        delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle

extension TabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }

    @objc dynamic func setupView() {
        view.backgroundColor = Color.background.color
    }

    @objc dynamic func setupBindings() { }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        navigationItem.title = viewController.title
        navigationItem.titleView = viewController.navigationItem.titleView
        navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems
        navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem
        navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems
        navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem
        navigationItem.backBarButtonItem = viewController.navigationItem.backBarButtonItem
        navigationItem.hidesBackButton = viewController.navigationItem.hidesBackButton
    }
}
