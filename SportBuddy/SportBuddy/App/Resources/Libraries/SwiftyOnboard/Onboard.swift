//
//  Onboard.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class Onboard: View {
    weak var dataSource: OnboardDataSource? {
        didSet {
            if let color = dataSource?.onboardBackgroundColorFor(self, atIndex: 0) {
                backgroundColor = color
            }
            dataSourceSet = true
        }
    }

    weak var delegate: OnboardDelegate?

    private let containerView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.setContentOffset(.zero, animated: false)
        return scrollView
    }()

    private(set) var overlay: OnboardOverlay?
    private var dataSourceSet = false
    private var pages = [OnboardPage]()
    private var shouldSwipe = true
    private var fadePages = true

    override var bounds: CGRect {
        didSet {
            if dataSourceSet {
                dataSourceSet = false
                loadView()
            }
        }
    }

    override init() {
        super.init()
        setup()
    }
}

extension Onboard {
    private func setup() {
        DispatchQueue.main.async {
            self.containerView.scrollRectToVisible(.zero, animated: true)
        }
    }

    private func loadView() {
        subviews.forEach { $0.removeFromSuperview() }
        setupBackgroundView()
        setupContainerView()
        setupPages()
        setupOverlayView()
        containerView.isScrollEnabled = shouldSwipe
    }

    private func setupBackgroundView() {
        if let background = dataSource?.onboardViewForBackground(self) {
            addSubview(background)
            sendSubviewToBack(background)
        }
    }

    private func setupContainerView() {
        containerView.frame = bounds
        containerView.delegate = self
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedPage)))
        addSubview(containerView)
    }

    private func setupPages() {
        guard let pageCount = dataSource?.onboardNumberOfPages(self) else { return }
        for index in 0..<pageCount {
            if let view = dataSource?.onboardPageForIndex(self, index: index) {
                contentMode = .scaleAspectFit
                containerView.addSubview(view)
                var viewFrame = bounds
                viewFrame.origin.x = bounds.width * CGFloat(index)
                view.frame = viewFrame
                pages.append(view)
            }
        }
        containerView.contentSize = CGSize(width: bounds.width * CGFloat(pageCount), height: bounds.height)
    }

    private func setupOverlayView() {
        if let dataSource = dataSource, let overlay = dataSource.onboardViewForOverlay(self) {
            overlay.page(count: dataSource.onboardNumberOfPages(self))
            addSubview(overlay)
            overlay.translatesAutoresizingMaskIntoConstraints = false
            overlay.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            overlay.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            overlay.topAnchor.constraint(equalTo: topAnchor).isActive = true
            overlay.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            overlay.pageControl.addAction(.init { [weak self] _ in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    let page = overlay.pageControl.currentPage
                    self.goToPage(index: page, animated: true)
                }
            }, for: .touchUpInside)
            self.overlay = overlay
        }
    }

    @objc private func tappedPage() {
        let currentpage = Int(getCurrentPosition())
        delegate?.onboard(self, tapped: currentpage)
    }

    private func colorForPosition(_ pos: CGFloat) -> UIColor? {
        guard let dataSource = dataSource else { return nil }
        let percentage: CGFloat = pos - CGFloat(Int(pos))

        let currentIndex = Int(pos - percentage)

        if currentIndex < dataSource.onboardNumberOfPages(self) - 1 {
            let color1 = dataSource.onboardBackgroundColorFor(self, atIndex: currentIndex)
            let color2 = dataSource.onboardBackgroundColorFor(self, atIndex: currentIndex + 1)

            if let color1 = color1, let color2 = color2 {
                return colorFrom(start: color1, end: color2, percent: percentage)
            }
        }
        return nil
    }

    private func colorFrom(start color1: UIColor, end color2: UIColor, percent: CGFloat) -> UIColor {
        func cofd(_ color1: CGFloat, _ color2: CGFloat, _ percent: CGFloat) -> CGFloat {
            let c1 = CGFloat(color1)
            let c2 = CGFloat(color2)
            return (c1 + ((c2 - c1) * percent))
        }
        return UIColor(red: cofd(color1.cgColor.components![0],
                                 color2.cgColor.components![0],
                                 percent),
                       green: cofd(color1.cgColor.components![1],
                                   color2.cgColor.components![1],
                                   percent),
                       blue: cofd(color1.cgColor.components![2],
                                  color2.cgColor.components![2],
                                  percent),
                       alpha: 1)
    }

    private func fadePageTransitions(containerView: UIScrollView, currentPage: Int) {
        pages.enumerated().forEach { index, page in
            page.alpha = 1 - abs(abs(containerView.contentOffset.x) - page.bounds.width * CGFloat(index)) / page.bounds.width
        }
    }
}

extension Onboard: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(getCurrentPosition())
        delegate?.onboard(self, currentPage: currentPage)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = Double(getCurrentPosition())
        overlay?.currentPage(index: Int(round(currentPosition)))
        if fadePages {
            fadePageTransitions(containerView: scrollView, currentPage: Int(getCurrentPosition()))
        }

        delegate?.onboard(self, leftEdge: currentPosition)
        if let overlayView = overlay {
            dataSource?.onboardOverlayForPosition(self, overlay: overlayView, for: currentPosition)
        }

        if let color = colorForPosition(CGFloat(currentPosition)) {
            backgroundColor = color
        }
    }
}

extension Onboard {
    var currentPage: Int{
        Int(getCurrentPosition())
    }

    func getCurrentPosition() -> CGFloat {
        let boundsWidth = containerView.bounds.width
        let contentOffset = containerView.contentOffset.x
        let currentPosition = contentOffset / boundsWidth
        return currentPosition
    }

    func goToPage(index: Int, animated: Bool) {
        guard let dataSource = dataSource else { return }
        if index < dataSource.onboardNumberOfPages(self) {
            containerView.setContentOffset(CGPoint(x: CGFloat(index) * bounds.width, y: .zero), animated: animated)
        }
    }
}
