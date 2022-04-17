//
//  TableView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import UIKit

class TableView: UITableView {
    // MARK: Initialization

    override init(frame: CGRect, style: Style) {
        super.init(frame: frame, style: style)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension TableView {
    private func setupView() {
        usingAutoLayout()
    }
}
