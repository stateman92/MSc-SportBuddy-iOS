//
//  ScrollingTextView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

class ScrollingTextView: TextView {
    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension ScrollingTextView {
    private func setupView() {
        isScrollEnabled = false
    }
}

// MARK: - Overridden methods

extension ScrollingTextView {
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        if size.height == UIView.noIntrinsicMetric {
            layoutManager.glyphRange(for: textContainer)
            size.height = layoutManager.usedRect(for: textContainer).height
            + textContainerInset.top
            + textContainerInset.bottom
        }

        if size.height > 250 {
            size.height = 250

            if !isScrollEnabled {
                isScrollEnabled = true
            }
        } else if isScrollEnabled {
            isScrollEnabled = false
        }

        return size
    }
}
