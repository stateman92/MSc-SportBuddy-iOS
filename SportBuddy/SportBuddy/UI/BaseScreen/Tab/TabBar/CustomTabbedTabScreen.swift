//
//  CustomTabbedTabScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import UIKit

class CustomTabbedTabScreen<ViewModel: BaseViewModel, Tabs: ScreenTabs>: BaseTabScreen<ViewModel, Tabs> {
    // MARK: Properties

    let tabBarView: TabBar
    private let bottomView = View()

    // MARK: Initialization

    init(selectedColor: UIColor, unselectedColor: UIColor) {
        tabBarView = .init(selectedColor: selectedColor, unselectedColor: unselectedColor)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupBottom()

        tabBarView.$selectedIndexSubject
            .dropFirst(1)
            .sink { [unowned self] in
                selectedViewController = viewControllers?[$0]
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
