//
//  SegmentedControl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 31..
//

import UIKit

final class SegmentedControl: UISegmentedControl {
    // MARK: Initialization

    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension SegmentedControl {
    private func setupView() {
        usingAutoLayout()
    }
}
