//
//  ScrollingScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import Combine
import UIKit

class ScrollingScreen<ViewModel: BaseViewModel>: BaseScreen<ViewModel> {
    // MARK: Properties

    let scrollView = ScrollView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Setups

extension ScrollingScreen {
    private func setupView() {
        scrollView.then {
            view.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero, safeArea: true)
        }
    }
}
