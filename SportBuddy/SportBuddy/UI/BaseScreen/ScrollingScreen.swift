//
//  ScrollingScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import Combine
import UIKit

class ScrollingScreen<State, Action, Domain, ViewModel: BaseViewModel<State, Action, Domain>>:
    BaseScreen<State, Action, Domain, ViewModel> {
    // MARK: Properties

    let scrollView = ScrollView()

    // MARK: - Setups

    override func setupView() {
        super.setupView()
        setupScrollView()
    }
}

// MARK: - Private methods

extension ScrollingScreen {
    private func setupScrollView() {
        scrollView.then {
            view.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero, safeArea: true)
        }
    }
}
