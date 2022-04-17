//
//  TabView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import UIKit

final class TabBar: UIControl {
    // MARK: Properties

    @Published var selectedIndexSubject = 0
    private let stackView = StackView()
    private let visualEffectView = VisualEffectView()
    private var tabBarItems: [TabBarItem] = []
    private var cancellables = Cancellables()

    private let selectedColor: UIColor
    private let unselectedColor: UIColor
    private let hasNotch = UIApplication.hasNotch

    // MARK: Initialization

    init(selectedColor: UIColor, unselectedColor: UIColor) {
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension TabBar {
    private func setupView() {
        setupVisualEffectView()
        setupStackView()
        if hasNotch {
            setHeight(91)
        }
    }

    private func setupVisualEffectView() {
        visualEffectView.then {
            let constant: CGFloat
            if hasNotch {
                constant = 8
                $0.layer.cornerRadius = 32
            } else {
                constant = .zero
                $0.layer.cornerRadius = 16
                $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            $0.clipsToBounds = true
            $0.set(style: .systemThinMaterial)
            addSubview($0)
            $0.anchorToSuperview(top: .zero, leading: constant, trailing: -constant)
            if !hasNotch {
                $0.anchorToBottom(constant: -constant)
            }
        }
    }

    private func setupStackView() {
        stackView.then {
            visualEffectView.contentView.addSubview($0)
            $0.distribution = .fillEqually
            $0.anchorToSuperview(top: 8, bottom: -8, leading: 8, trailing: -8)
        }
    }
}

// MARK: - Public methods

extension TabBar {
    func setupItems(from viewControllers: [UIViewController]?) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        tabBarItems = []

        viewControllers?.forEach {
            let tabBarItem = TabBarItem(tabBarItem: $0.tabBarItem,
                                        unselectedColor: unselectedColor,
                                        selectedColor: selectedColor)
            tabBarItems.append(tabBarItem)
            stackView.addArrangedSubview(tabBarItem)
        }

        tabBarItems.forEach { button in
            button.tapped = { [weak self] in
                guard let self = self else { return }
                let index = self.tabBarItems.firstIndex(of: button) ?? .zero
                self.sendActions(for: .valueChanged)
                self.selectedIndexSubject = index
            }
        }

        $selectedIndexSubject
            .sink { [unowned self] in setSelectedIndex(index: $0) }
            .store(in: &cancellables)
    }

    func setSelectedIndex(index: Int) {
        let selectedItem = tabBarItems[index]
        let deselectItems = tabBarItems.filter { $0 != selectedItem }
        deselectItems.forEach { $0.isSelected = false }
        selectedItem.isSelected = true
    }
}
