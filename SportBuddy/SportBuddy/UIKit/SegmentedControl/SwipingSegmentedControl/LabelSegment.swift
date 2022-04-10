//
//  LabelSegment.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 31..
//

import UIKit

final class LabelSegment: SwipingSegment {
    // MARK: Properties

    private let text: String
    private let numberOfLines: Int
    private let normalBackgroundColor: UIColor
    private let normalFont: UIFont
    private let normalTextColor: UIColor
    private let selectedFont: UIFont
    private let selectedTextColor: UIColor
    private let selectedBackgroundColor: UIColor

    private(set) lazy var normalView: UIView = {
        createLabel(backgroundColor: normalBackgroundColor, font: normalFont, textColor: normalTextColor)
    }()

    private(set) lazy var selectedView: UIView = {
        createLabel(backgroundColor: selectedBackgroundColor, font: selectedFont, textColor: selectedTextColor)
    }()
    var intrinsicContentSize: CGSize? {
        selectedView.intrinsicContentSize.applying(.init(scaleX: 1.5, y: 1.5))
    }

    // MARK: Initialization

    init(text: String = .init(),
         numberOfLines: Int = 1,
         normalBackgroundColor: UIColor = .clear,
         normalFont: UIFont = .systemFont(ofSize: 13),
         normalTextColor: UIColor = .black,
         selectedFont: UIFont = .systemFont(ofSize: 13, weight: .medium),
         selectedTextColor: UIColor = .black,
         selectedBackgroundColor: UIColor = .clear) {
        self.text = text
        self.numberOfLines = numberOfLines
        self.normalBackgroundColor = normalBackgroundColor
        self.normalFont = normalFont
        self.normalTextColor = normalTextColor
        self.selectedFont = selectedFont
        self.selectedTextColor = selectedTextColor
        self.selectedBackgroundColor = selectedBackgroundColor
    }
}

// MARK: - Private methods

extension LabelSegment {
    private func createLabel(backgroundColor: UIColor, font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = numberOfLines
        label.backgroundColor = backgroundColor
        label.font = font
        label.textColor = textColor
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }
}

// MARK: - Public methods

extension LabelSegment {
    // swiftlint:disable:next function_parameter_count
    class func segments(withTitles titles: [String],
                        numberOfLines: Int = 1,
                        normalBackgroundColor: UIColor,
                        normalFont: UIFont,
                        normalTextColor: UIColor,
                        selectedBackgroundColor: UIColor,
                        selectedFont: UIFont,
                        selectedTextColor: UIColor) -> [SwipingSegment] {
        titles.map {
            LabelSegment(text: $0,
                         numberOfLines: numberOfLines,
                         normalBackgroundColor: normalBackgroundColor,
                         normalFont: normalFont,
                         normalTextColor: normalTextColor,
                         selectedFont: selectedFont,
                         selectedTextColor: selectedTextColor,
                         selectedBackgroundColor: selectedBackgroundColor)
        }
    }
}
