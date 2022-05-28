//
//  MainScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

// swiftlint:disable:next colon
final class MainScreen:
    CustomTabbedTabScreen<MainViewModelState, MainViewModelCommand, MainDomain, MainViewModel, MainScreenTabs> {
    // MARK: Initialization

    init() {
        super.init(selectedColor: UIColor {
            switch $0.userInterfaceStyle {
            case .dark: return .white
            default: return .darkGray
            }
        }, unselectedColor: .systemGray)
    }
}
