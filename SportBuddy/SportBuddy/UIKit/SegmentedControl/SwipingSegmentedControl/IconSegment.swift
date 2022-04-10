//
//  IconSegment.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 31..
//

import UIKit

final class IconSegment: SwipingSegment {
    // MARK: Properties

    private let icon: UIImage
    private let iconSize: CGSize
    private let normalBackgroundColor: UIColor
    private let normalIconTintColor: UIColor
    private let selectedBackgroundColor: UIColor
    private let selectedIconTintColor: UIColor

    private(set) lazy var normalView: UIView = {
        createView(backgroundColor: normalBackgroundColor, iconTintColor: normalIconTintColor)
    }()

    private(set) lazy var selectedView: UIView = {
        createView(backgroundColor: selectedBackgroundColor, iconTintColor: selectedIconTintColor)
    }()
    var intrinsicContentSize: CGSize? {
        nil
    }

    // MARK: Initialization

    init(icon: UIImage,
         iconSize: CGSize,
         normalBackgroundColor: UIColor = .clear,
         normalIconTintColor: UIColor,
         selectedBackgroundColor: UIColor = .clear,
         selectedIconTintColor: UIColor) {
        self.icon = icon.withRenderingMode(.alwaysTemplate)
        self.iconSize = iconSize
        self.normalBackgroundColor = normalBackgroundColor
        self.normalIconTintColor = normalIconTintColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.selectedIconTintColor = selectedIconTintColor
    }
}

// MARK: - Private methods

extension IconSegment {
    private func createView(backgroundColor: UIColor, iconTintColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        let imageView = UIImageView(image: icon)
        imageView.frame = CGRect(x: 0, y: 0, width: iconSize.width, height: iconSize.height)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = iconTintColor
        imageView.autoresizingMask = [.flexibleTopMargin,
                                      .flexibleLeftMargin,
                                      .flexibleRightMargin,
                                      .flexibleBottomMargin]
        view.addSubview(imageView)
        return view
    }
}

// MARK: - Public methods

extension IconSegment {
    // swiftlint:disable:next function_parameter_count
    class func segments(withIcons icons: [UIImage],
                        iconSize: CGSize,
                        normalBackgroundColor: UIColor,
                        normalIconTintColor: UIColor,
                        selectedBackgroundColor: UIColor,
                        selectedIconTintColor: UIColor) -> [SwipingSegment] {
        icons.map {
            IconSegment(icon: $0,
                        iconSize: iconSize,
                        normalBackgroundColor: normalBackgroundColor,
                        normalIconTintColor: normalIconTintColor,
                        selectedBackgroundColor: selectedBackgroundColor,
                        selectedIconTintColor: selectedIconTintColor)
        }
    }
}
