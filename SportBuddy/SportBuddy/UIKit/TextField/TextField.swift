//
//  TextField.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 27..
//

import UIKit

class TextField: UITextField {
    // MARK: Properties

    override var tintColor: UIColor! {
        didSet {
            layoutSubviews()
        }
    }

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

// MARK: - Overridden methods

extension TextField {
    override func layoutSubviews() {
        super.layoutSubviews()

        subviews.compactMap { $0 as? UIButton }.forEach { button in
            button.setImage(button.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = tintColor
        }
    }
}

// MARK: - Setups

extension TextField {
    private func setupView() {
        usingAutoLayout()
        font = Fonts.Fredoka.regular.font(size: font?.pointSize ?? 17)
    }
}
