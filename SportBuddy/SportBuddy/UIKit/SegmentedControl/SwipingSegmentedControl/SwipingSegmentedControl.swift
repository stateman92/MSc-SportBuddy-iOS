//
//  SwipingSegmentedControl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 31..
//

import UIKit

final class SwipingSegmentedControl: UIControl {
    enum Option {
        case indicatorViewBackgroundColor(UIColor)
        case indicatorViewInset(CGFloat)
        case indicatorViewBorderWidth(CGFloat)
        case indicatorViewBorderColor(UIColor)

        case alwaysAnnouncesValue(Bool)
        case announcesValueImmediately(Bool)
        case panningDisabled(Bool)

        case animationDuration(TimeInterval)
        case animationSpringDamping(CGFloat)

        case backgroundColor(UIColor)
        case cornerRadius(CGFloat)
    }

    class IndicatorView: View {
        fileprivate let segmentMaskView = UIView()
        var cornerRadius: CGFloat = .zero {
            didSet {
                layer.cornerRadius = cornerRadius
                segmentMaskView.layer.cornerRadius = cornerRadius
            }
        }
        override var frame: CGRect {
            didSet {
                segmentMaskView.frame = frame
            }
        }
        override init() {
            super.init()
            segmentMaskView.backgroundColor = .black
        }
    }

    private enum Constants {
        static let minimumIntrinsicContentSizeHeight: CGFloat = 32
        static let minimumSegmentIntrinsicContentSizeWidth: CGFloat = 20
    }

    static let noSegment = -1
    private(set) var index = noSegment

    var segments: [SwipingSegment] = [] {
        didSet {
            applySegments()
        }
    }

    let indicatorView = IndicatorView()

    var alwaysAnnouncesValue = false
    var announcesValueImmediately = false
    var panningDisabled = false

    var indicatorViewInset: CGFloat = 2 {
        didSet {
            updateCornerRadii()
        }
    }
    var animationDuration: TimeInterval = 0.3
    var animationSpringDamping: CGFloat = 0.75

    private let normalSegmentViewsContainerView = UIView()
    private let selectedSegmentViewsContainerView = UIView()
    private let pointerInteractionViewsContainerView = UIView()

    private var initialIndicatorViewFrame: CGRect?

    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var panGestureRecognizer: UIPanGestureRecognizer!

    private var normalSegmentViews: [UIView] = []
    private var normalSegmentViewCount: Int { normalSegmentViews.count }

    private var selectedSegmentViews: [UIView] = []

    var segmentPadding: CGFloat = 14 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}

extension SwipingSegmentedControl {
    var indicatorViewBackgroundColor: UIColor? {
        get {
            indicatorView.backgroundColor
        }
        set {
            indicatorView.backgroundColor = newValue
        }
    }

    var indicatorViewBorderWidth: CGFloat {
        get {
            indicatorView.layer.borderWidth
        }
        set {
            indicatorView.layer.borderWidth = newValue
        }
    }

    var indicatorViewBorderColor: UIColor? {
        get {
            indicatorView.layer.borderColor.map(UIColor.init(cgColor:))
        }
        set {
            indicatorView.layer.borderColor = newValue?.cgColor
        }
    }

    private var allSegmentViews: [UIView] {
        normalSegmentViews + selectedSegmentViews
    }
    private var safeIndex: Int {
        index >= .zero ? index : .zero
    }
    private var lastIndex: Int {
        segments.endIndex - 1
    }
    private var totalInsetSize: CGFloat {
        indicatorViewInset * 2
    }
    private var isLayoutDirectionRightToLeft: Bool {
        UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
    }
}

extension SwipingSegmentedControl {
    func set(index: Int, animated: Bool = true, shouldSendValueChangedEvent: Bool = false) {
        guard segments.indices.contains(index) || index == Self.noSegment else { return }

        let previousIndex = self.index
        self.index = index

        let shouldSendEvent = (index != previousIndex || alwaysAnnouncesValue) && shouldSendValueChangedEvent
        let shouldSendEventBeforeAnimations = announcesValueImmediately && shouldSendEvent
        let shouldSendEventAfterAnimations = !announcesValueImmediately && shouldSendEvent

        if shouldSendEventBeforeAnimations {
            sendActions(for: .valueChanged)
        }
        performIndexChange(fromPreviousIndex: previousIndex,
                           toNewIndex: index,
                           animated: animated,
                           completion: { [weak self] in
            if shouldSendEventAfterAnimations {
                self?.sendActions(for: .valueChanged)
            }
        })
    }

    // swiftlint:disable:next cyclomatic_complexity
    func setOptions(_ options: [Option]) {
        options.forEach {
            switch $0 {
            case let .indicatorViewBackgroundColor(value):
                indicatorViewBackgroundColor = value
            case let .indicatorViewInset(value):
                indicatorViewInset = value
            case let .indicatorViewBorderWidth(value):
                indicatorViewBorderWidth = value
            case let .indicatorViewBorderColor(value):
                indicatorViewBorderColor = value
            case let .alwaysAnnouncesValue(value):
                alwaysAnnouncesValue = value
            case let .announcesValueImmediately(value):
                announcesValueImmediately = value
            case let .panningDisabled(value):
                panningDisabled = value
            case let .backgroundColor(value):
                backgroundColor = value
            case let .cornerRadius(value):
                cornerRadius = value
            case let .animationDuration(value):
                animationDuration = value
            case let .animationSpringDamping(value):
                animationSpringDamping = value
            }
        }
    }

    convenience init() {
        self.init(frame: .zero)
        usingAutoLayout()
        layer.masksToBounds = true

        normalSegmentViewsContainerView.clipsToBounds = true
        addSubview(normalSegmentViewsContainerView)

        addSubview(indicatorView)

        selectedSegmentViewsContainerView.clipsToBounds = true
        addSubview(selectedSegmentViewsContainerView)
        selectedSegmentViewsContainerView.layer.mask = indicatorView.segmentMaskView.layer

        pointerInteractionViewsContainerView.clipsToBounds = true
        addSubview(pointerInteractionViewsContainerView)

        addTapGestureRecognizer { [weak self] gestureRecognizer in
            guard let self = self else { return }
            self.set(index: self.closestIndex(toPoint: gestureRecognizer.location(in: self)),
                     shouldSendValueChangedEvent: true)
        }

        addPanGestureRecognizer { [weak self] gestureRecognizer in
            guard let self = self else { return }
            switch gestureRecognizer.state {
            case .began:
                self.initialIndicatorViewFrame = self.indicatorView.frame
            case .changed:
                var frame = self.initialIndicatorViewFrame!
                frame.origin.x += gestureRecognizer.translation(in: self).x
                frame.origin.x = max(min(frame.origin.x, self.bounds.width - self.indicatorViewInset - frame.width),
                                     self.indicatorViewInset)
                self.indicatorView.frame = frame
            case .ended, .failed, .cancelled:
                self.set(index: self.closestIndex(toPoint: self.indicatorView.center),
                         shouldSendValueChangedEvent: true)
            default: break
            }
        }.delegate = self

        applySegments(shouldResetIndex: false)
    }
}

extension SwipingSegmentedControl {
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            updateCornerRadii()
        }
    }

    override var intrinsicContentSize: CGSize {
        let segmentIntrinsicContentSizes = segments.map {
            $0.intrinsicContentSize ?? .zero
        }

        let maxSegmentIntrinsicContentSizeWidth = segmentIntrinsicContentSizes.map(\.width).max() ?? .zero
        let maxSegmentIntrinsicContentSizeHeight = segmentIntrinsicContentSizes.map(\.height).max() ?? .zero

        let singleSegmentWidth = totalInsetSize
            + max(maxSegmentIntrinsicContentSizeWidth, Constants.minimumSegmentIntrinsicContentSizeWidth)
            + segmentPadding

        let width = ceil(CGFloat(segments.count) * singleSegmentWidth)
        let height = ceil(max(maxSegmentIntrinsicContentSizeHeight + totalInsetSize,
                              Constants.minimumIntrinsicContentSizeHeight))

        return CGSize(width: width, height: height)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard normalSegmentViewCount >= 1 else { return }

        normalSegmentViewsContainerView.frame = bounds
        selectedSegmentViewsContainerView.frame = bounds
        pointerInteractionViewsContainerView.frame = bounds

        indicatorView.frame = frameForElement(atIndex: safeIndex)

        normalSegmentViews.enumerated().forEach { value in
            let frame = frameForElement(atIndex: value.offset)
            normalSegmentViews[value.offset].frame = frame
            selectedSegmentViews[value.offset].frame = frame
        }
    }
}

extension SwipingSegmentedControl {

    private func setIndicatorViewVisible(_ isVisible: Bool, animated: Bool, completion: @escaping () -> Void = { }) {
        UIView.animate(withDuration: (animated ? 0.1 : .zero),
                       delay: .zero,
                       options: [.beginFromCurrentState, .curveEaseIn],
                       animations: {
            self.selectedSegmentViewsContainerView.alpha = isVisible ? 1 : .zero
            self.indicatorView.alpha = isVisible ? 1 : .zero
        }, completion: { _ in
            completion()
        })
    }

    private func performIndexChange(fromPreviousIndex previousIndex: Int,
                                    toNewIndex newIndex: Int,
                                    animated: Bool,
                                    completion: @escaping () -> Void) {
        func moveIndicatorViewToIndex(animated: Bool, completion: @escaping () -> Void) {
            guard index >= .zero else { return }

            UIView.animate(withDuration: animated ? animationDuration : .zero,
                           delay: .zero,
                           usingSpringWithDamping: animationSpringDamping,
                           initialSpringVelocity: .zero,
                           options: [.beginFromCurrentState, .curveEaseOut],
                           animations: {
                self.indicatorView.frame = self.normalSegmentViews[self.index].frame
                self.layoutIfNeeded()
            }, completion: { _ in
                completion()
            })
        }

        if index == Self.noSegment {
            setIndicatorViewVisible(false, animated: animated, completion: completion)
        } else if previousIndex == Self.noSegment {
            moveIndicatorViewToIndex(animated: false) { [weak self] in
                self?.setIndicatorViewVisible(true, animated: animated, completion: completion)
            }
        } else {
            moveIndicatorViewToIndex(animated: animated, completion: completion)
        }
    }

    private func applySegments(shouldResetIndex: Bool = true) {
        normalSegmentViews.forEach { $0.removeFromSuperview() }
        normalSegmentViews.removeAll()

        selectedSegmentViews.forEach { $0.removeFromSuperview() }
        selectedSegmentViews.removeAll()

        segments.forEach { segment in
            segment.normalView.clipsToBounds = true
            segment.normalView.isAccessibilityElement = false

            segment.selectedView.clipsToBounds = true

            normalSegmentViewsContainerView.addSubview(segment.normalView)
            normalSegmentViews.append(segment.normalView)

            selectedSegmentViewsContainerView.addSubview(segment.selectedView)
            selectedSegmentViews.append(segment.selectedView)
        }

        updateCornerRadii()
        if shouldResetIndex {
            resetIndex()
        }

        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    private func updateCornerRadii() {
        indicatorView.cornerRadius = cornerRadius - indicatorViewInset
        allSegmentViews.forEach { $0.layer.cornerRadius = indicatorView.cornerRadius }
    }

    private func frameForElement(atIndex index: Int) -> CGRect {
        let elementWidth = (bounds.width - totalInsetSize) / CGFloat(normalSegmentViewCount)
        let x = CGFloat(isLayoutDirectionRightToLeft ? lastIndex - index : index) * elementWidth
        return CGRect(x: x + indicatorViewInset,
                      y: indicatorViewInset,
                      width: elementWidth,
                      height: bounds.height - totalInsetSize)
    }

    private func resetIndex() {
        set(index: (segments.isEmpty ? -1 : .zero), animated: false)
    }

    private func closestIndex(toPoint point: CGPoint) -> Int {
        let distances = normalSegmentViews.map { abs(point.x - $0.center.x) }
        return Int(distances.firstIndex(of: distances.min()!)!)
    }
}

extension SwipingSegmentedControl: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGestureRecognizer {
            return indicatorView.frame.contains(gestureRecognizer.location(in: self)) && !panningDisabled
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
