//
//  ImageView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 26..
//

import UIKit

final class ImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageView {
    private func setupView() {
        usingAutoLayout()
        contentMode = .scaleAspectFit
    }
}
