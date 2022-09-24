//
//  ButtonLabel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 26..
//

import UIKit

final class ButtonLabel: UIButton {
    // MARK: Nested types

    enum Style {
        case primary
        case secondary
        case tertiary
        case label(textColor: UIColor)

        static var label: Self {
            .label(textColor: Color.primary.color)
        }

        fileprivate var configuration: Configuration {
            var configuration: Configuration
            switch self {
            case .primary:
                configuration = .filled()
                configuration.baseBackgroundColor = Color.primary.color
            case .secondary:
                configuration = .borderedProminent()
                configuration.baseBackgroundColor = .white.withAlphaComponent(0.5)
                configuration.baseForegroundColor = Color.primary.color
            case .tertiary:
                configuration = .borderless()
                configuration.baseForegroundColor = Color.primary.color
            case let .label(textColor):
                configuration = .plain()
                configuration.baseForegroundColor = textColor
            }
            return configuration
        }

        fileprivate var isLabel: Bool {
            if case .label = self {
                return true
            }
            return false
        }
    }

    enum Size {
        case huge
        case large
        case normal
        case small
        case tiny

        fileprivate var height: CGFloat {
            switch self {
            case .huge: return 64
            case .large: return 56
            case .normal: return 48
            case .small: return 40
            case .tiny: return 32
            }
        }

        fileprivate var fontSize: CGFloat {
            switch self {
            case .huge: return 24
            case .large: return 21
            case .normal: return 18
            case .small: return 15
            case .tiny: return 12
            }
        }
    }

    enum Image {
        enum Content {
            case image(UIImage)
            case activityIndicator
        }

        case left(Content)
        case right(Content)
        case none

        fileprivate var imagePlacement: NSDirectionalRectEdge? {
            switch self {
            case .left: return .leading
            case .right: return .trailing
            case .none: return nil
            }
        }

        fileprivate var content: Content? {
            switch self {
            case let .left(content): return content
            case let .right(content): return content
            case .none: return nil
            }
        }
    }

    // MARK: Properties

    private var heightConstraint: NSLayoutConstraint!
    private var config = Configuration.plain()
    private var size: Size
    private var configIsLabel: Bool {
        !heightConstraint.isActive
    }

    override var intrinsicContentSize: CGSize {
        if !configIsLabel {
            return super.intrinsicContentSize
        }
        let label = UILabel()
        label.font = titleLabel?.font
        label.text = titleLabel?.text
        if config.image == nil {
            return label.intrinsicContentSize
        }
        let imageSize = imageView?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) ?? .zero
        let labelHeight = label.intrinsicContentSize.height
        let height = max(imageSize.height, labelHeight)
        return .init(width: label.intrinsicContentSize.width + config.imagePadding + imageSize.width, height: height)
    }

    // MARK: Initialization

    init(text: String = .init(),
         style: Style = .primary,
         size: Size = .normal,
         image: Image = .none,
         tapped: (() -> Void)? = nil) {
        self.size = size
        super.init(frame: .zero)
        setupView(text: text, style: style, size: size, image: image, tapped: tapped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension ButtonLabel {
    private func setupView(text: String, style: Style, size: Size, image: Image, tapped: (() -> Void)?) {
        heightConstraint = heightAnchor.constraint(equalToConstant: .zero)
        heightConstraint.isActive = true
        usingAutoLayout()
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.imagePadding = 5
        config.cornerStyle = .large
        setup(text: text, style: style, size: size, image: image, tapped: tapped)
    }

    private func setup(text: String, style: Style, size: Size, image: Image, tapped: (() -> Void)?) {
        setup(text: text)
        setup(style: style)
        setup(size: size)
        setup(image: image)
        if let tapped {
            self.tapped(tapped: tapped)
        }
    }
}

// MARK: - Public methods

extension ButtonLabel {
    @discardableResult func tapped(tapped: @escaping () -> Void) -> UIAction {
        let action = UIAction { _ in tapped() }
        addAction(action, for: .touchUpInside)
        return action
    }

    func remove(action: UIAction) {
        removeAction(action, for: .touchUpInside)
    }

    func setup(text: String) {
        config.attributedTitle = AttributedString(text)
        config.attributedTitle?.font = Fonts.Fredoka.regular.font(size: size.fontSize)
        configuration = config
    }

    func setup(style: Style) {
        let oldImagePlacement = config.imagePlacement
        let oldImage = config.image
        let oldAttributedTitle = config.attributedTitle
        let oldImagePadding = config.imagePadding
        let oldTitlePadding = config.titlePadding
        let oldCornerStyle = config.cornerStyle
        let oldShowsActivityIndicator = config.showsActivityIndicator

        config = style.configuration
        heightConstraint.isActive = !style.isLabel
        isUserInteractionEnabled = !style.isLabel
        if style.isLabel {
            config.contentInsets = .zero
        }

        config.attributedTitle = oldAttributedTitle
        config.attributedTitle?.font = Fonts.Fredoka.regular.font(size: size.fontSize)
        config.image = oldImage
        config.imagePlacement = oldImagePlacement
        config.imagePadding = oldImagePadding
        config.titlePadding = oldTitlePadding
        config.cornerStyle = oldCornerStyle
        config.showsActivityIndicator = oldShowsActivityIndicator

        configuration = config
    }

    func setup(size: Size) {
        self.size = size
        heightConstraint.constant = size.height
        if config.attributedTitle == nil {
            config.attributedTitle = AttributedString()
        }
        config.attributedTitle?.font = Fonts.Fredoka.regular.font(size: size.fontSize)
        configuration = config
    }

    func setup(image: Image) {
        if let imagePlacement = image.imagePlacement {
            config.imagePlacement = imagePlacement
        }
        if let content = image.content {
            switch content {
            case let .image(image):
                config.image = image
            case .activityIndicator:
                config.showsActivityIndicator = true
            }
        } else {
            config.showsActivityIndicator = false
        }
        configuration = config
    }
}
