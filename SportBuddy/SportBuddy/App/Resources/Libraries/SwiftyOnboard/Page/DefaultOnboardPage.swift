//
//  DefaultOnboardPage.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class DefaultOnboardPage: View {
    let title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()

    let subTitle: UILabel = {
        let label = UILabel()
        label.text = "Sub Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init() {
        super.init()
        setup()
    }
}

extension DefaultOnboardPage {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = true
        addSubview(imageView)

        let margin = layoutMarginsGuide
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 30).isActive = true
        imageView.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30).isActive = true
        imageView.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.5).isActive = true

        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 30).isActive = true
        title.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30).isActive = true
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true

        addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 30).isActive = true
        subTitle.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30).isActive = true
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0).isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
