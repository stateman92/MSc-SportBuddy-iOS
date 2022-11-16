//
//  OnboardingPage.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class OnboardingPage: View {
    // MARK: Properties

    let title = ButtonLabel(style: .label(textColor: .white))
    let subTitle = ButtonLabel(style: .label(textColor: .black))
    let imageView: UIImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
    }()

    // MARK: Initialization

    override init() {
        super.init()
        setup()
    }
}

// MARK: - OnboardPage

extension OnboardingPage: OnboardPage { }

// MARK: - Setups

extension OnboardingPage {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = true

        addSubview(imageView)
        imageView.anchorToSuperview(top: 144, leading: 32, trailing: -32)
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true

        addSubview(title)
        title.anchorToSuperview(leading: 32, trailing: -32)
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -48).isActive = true

        addSubview(subTitle)
        subTitle.anchorToSuperview(leading: 32, trailing: -32)
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 48).isActive = true
    }
}
