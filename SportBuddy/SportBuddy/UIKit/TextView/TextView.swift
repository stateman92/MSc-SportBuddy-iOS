//
//  TextView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

class TextView: UITextView {
    // MARK: Initialization

    init() {
        super.init(frame: .zero, textContainer: nil)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension TextView {
    private func setupView() {
        usingAutoLayout()
        backgroundColor = .clear // default background on real device iOS 15 is .black!
        font = Fonts.Fredoka.regular.font(size: font?.pointSize ?? 17)
    }
}
