//
//  LoadingOverlayView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

final class LoadingOverlayView: View {
    // MARK: Properties

    private let background = View()
    private let indicator = UIActivityIndicatorView(style: .large)

    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension LoadingOverlayView {
    private func setupView() {
        setupBackground()
        setupIndicator()
    }

    private func setupBackground() {
        background.then {
            $0.alpha = 0.5
            $0.backgroundColor = .black

            addSubview($0)

            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }

    private func setupIndicator() {
        indicator.then {
            $0.color = .white
            $0.startAnimating()

            background.addSubview($0)

            $0.anchorToCenter()
        }
    }
}
