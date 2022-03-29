//
//  OnboardingPage.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class OnboardingPage: View {
    let title = ButtonLabel(style: .label)
    let subTitle = ButtonLabel(style: .label)

    let imageView: UIImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override init() {
        super.init()
        setup()
    }
}

extension OnboardingPage: OnboardPage { }

extension OnboardingPage {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = true
        addSubview(imageView)

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 128).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true

        addSubview(title)
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -32).isActive = true

        addSubview(subTitle)
        subTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 48).isActive = true
    }
}
