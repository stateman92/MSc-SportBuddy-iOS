//
//  MainScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class MainScreen: CustomTabbedTabScreen<MainViewModelState, MainViewModelAction, MainViewModel, MainScreenTabs> {
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
