//
//  CustomTabbedTabScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import UIKit

class CustomTabbedTabScreen<State,
                            Action,
                            Domain,
                            ViewModel: BaseViewModel<State, Action, Domain>,
                            Tabs: ScreenTabs>: BaseTabScreen<State, Action, Domain, ViewModel, Tabs> {
    // MARK: Properties

    let tabBarView: TabBar
    private let bottomView = View()

    // MARK: Initialization

    init(selectedColor: UIColor, unselectedColor: UIColor) {
        tabBarView = .init(selectedColor: selectedColor, unselectedColor: unselectedColor)
        super.init()
    }

    // MARK: - Setups

    override func setupView() {
        super.setupView()
        setupTabBar()
        setupBottom()
    }

    override func setupBindings() {
        super.setupBindings()
        tabBarView.$selectedIndexSubject
            .dropFirst(1)
            .compactMap { [unowned self] in viewControllers?[$0] }
            .sink { [unowned self] destinationViewController in
                if let delegate = delegate {
                    if let result = delegate.tabBarController?(self, shouldSelect: destinationViewController) {
                        if result {
                            selectedViewController = destinationViewController
                        }
                    } else {
                        selectedViewController = destinationViewController
                    }
                } else {
                    selectedViewController = destinationViewController
                }
                if let selectedViewController = selectedViewController {
                    delegate?.tabBarController?(self, didSelect: selectedViewController)
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Overridden methods

    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        tabBarView.setupItems(from: viewControllers)
        tabBarView.setSelectedIndex(index: .zero)
        selectedViewController = viewControllers?[.zero]

        let bottomSafeArea = tabBarView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        additionalSafeAreaInsets = .init(top: .zero,
                                         left: .zero,
                                         bottom: bottomSafeArea - UIApplication.bottomNotchSize,
                                         right: .zero)
    }
}

// MARK: - Public methods

extension CustomTabbedTabScreen {
    func setSelectedIndex(index: Int) {
        selectedViewController = viewControllers?[index]
        tabBarView.selectedIndexSubject = index
    }
}

// MARK: - Setups

extension CustomTabbedTabScreen {
    private func setupTabBar() {
        tabBar.isHidden = true
        tabBarView.then {
            view.addSubview($0)
            $0.anchorToLeading()
            $0.anchorToTrailing()
            $0.anchorToBottom()
        }
    }

    private func setupBottom() {
        bottomView.then {
            view.addSubview($0)
            $0.topAnchor.constraint(equalTo: tabBarView.bottomAnchor).isActive = true
            $0.anchorToLeading()
            $0.anchorToTrailing()
            $0.anchorToBottom()
        }
    }
}
