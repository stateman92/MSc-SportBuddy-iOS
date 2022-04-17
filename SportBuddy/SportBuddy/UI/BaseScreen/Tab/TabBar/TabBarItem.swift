//
//  TabBarItem.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Combine
import UIKit

final class TabBarItem: View {
    // MARK: Properties

    var isSelected = false {
        didSet {
            setSelected(isSelected)
        }
    }
    var tapped: (() -> Void)?

    private let imageView = ImageView()
    private let label = Label()
    private let tapGestureRecognizer = UITapGestureRecognizer()
    private let tabBarItem: UITabBarItem
    private let unselectedColor: UIColor
    private let selectedColor: UIColor

    // MARK: Initialization

    init(tabBarItem: UITabBarItem, unselectedColor: UIColor, selectedColor: UIColor) {
        self.tabBarItem = tabBarItem
        self.unselectedColor = unselectedColor
        self.selectedColor = selectedColor
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension TabBarItem {
    private func setupView() {
        setupImageView()
        setupLabel()

        addTapGestureRecognizer { [weak self] in
            self?.tapped?()
        }
    }

    private func setupImageView() {
        imageView.then {
            addSubview($0)
            $0.image = tabBarItem.image
            $0.contentMode = .scaleAspectFit
            $0.anchorToTop()
            $0.setWidth(33)
            $0.setHeight(33)
            $0.anchorToCenterX()
        }
    }

    private func setupLabel() {
        label.then {
            addSubview($0)
            $0.text = tabBarItem.title
            $0.font = Fonts.Fredoka.regular.font(size: 12)
            $0.textAlignment = .center
            $0.numberOfLines = 1
            $0.setContentHuggingPriority(.required, for: .vertical)
            $0.anchorToCenterX()
            $0.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4).isActive = true
            $0.anchorToBottom()
        }
    }

    private func setSelected(_ selected: Bool) {
        UIView.animate(withDuration: 0.1, options: [.allowUserInteraction, .beginFromCurrentState]) { [self] in
            imageView.image = selected ? tabBarItem.selectedImage : tabBarItem.image
            imageView.tintColor = selected ? selectedColor : unselectedColor
            label.textColor = selected ? selectedColor : unselectedColor
        }
    }
}
