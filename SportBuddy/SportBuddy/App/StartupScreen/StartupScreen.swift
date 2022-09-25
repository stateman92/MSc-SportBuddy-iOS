//
//  StartupScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 24..
//

import UIKit

final class StartupScreen: UIViewController { }

// MARK: - Lifecycle

extension StartupScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setups

extension StartupScreen {
    private func setup() {
        splashViewController?.then {
            addChild($0)
            view.addSubview($0.view)
            $0.view.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}

// MARK: - Helpers

extension StartupScreen {
    private var splashViewController: UIViewController? {
        UIStoryboard(name: Constants.Files.launchScreen, bundle: nil).instantiateInitialViewController()
    }
}
