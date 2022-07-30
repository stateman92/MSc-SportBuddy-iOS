//
//  ViewController.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

import UIKit

class ViewController: UIViewController {
    // MARK: Nested types

    struct BackgroundViewOptions {
        var showing = true
        var animating = true
    }

    // MARK: Properties

    var backgroundViewOptions = BackgroundViewOptions() {
        didSet {
            updateBackgroundView()
        }
    }
    var isVisible = false
    let backgroundView = BackgroundView()
    override var title: String? {
        didSet {
            tabBarItem.title = title
        }
    }

    // MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isVisible = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isVisible = false
    }

    @objc dynamic func setupView() {
        view.backgroundColor = Color.background.color
        hideKeyboardWhenTappedOutside()
        updateBackgroundView()
    }

    @objc dynamic func setupBindings() { }
}

// MARK: - Private methods

extension ViewController {
    private func updateBackgroundView() {
        if backgroundViewOptions.showing, backgroundView.superview == nil {
            backgroundView.then {
                view.addSubview($0)
                view.sendSubviewToBack($0)
                $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
            }
        } else if !backgroundViewOptions.showing, backgroundView.superview != nil {
            backgroundView.removeFromSuperview()
        }

        backgroundView.isAnimating = backgroundViewOptions.animating
    }
}
