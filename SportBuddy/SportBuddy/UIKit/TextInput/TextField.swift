//
//  TextField.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 27..
//

import UIKit

class TextField: UITextField {
    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextField {
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
