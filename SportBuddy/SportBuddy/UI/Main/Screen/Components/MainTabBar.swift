//
//  MainTabBar.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class MainTabBar: UITabBar {
    // MARK: Properties

    init(cornerRadius: CGFloat = 20) {
        super.init(frame: .zero)
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
