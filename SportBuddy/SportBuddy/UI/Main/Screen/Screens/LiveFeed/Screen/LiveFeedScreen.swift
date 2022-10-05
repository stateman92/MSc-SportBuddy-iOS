//
//  LiveFeedScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 12..
//

import UIKit

final class LiveFeedScreen:
    TabScreen<LiveFeedViewModelState, LiveFeedViewModelCommand, LiveFeedDomainImpl, LiveFeedViewModel> {
    // MARK: Properties

    private let tableView = AutoReversedTableView<LiveFeedTableViewCell, LiveFeedResponseDTO>(
        style: .grouped, reversed: false) { cell, data in
        cell.setup(with: data)
    }
    private let inputField = LiveFeedInputField()
    private var bottomAnchor: NSLayoutConstraint?
    private let welcomeBottomView = ButtonLabel(text: L10n.Live.Feed.Title.Second.line,
                                                style: .label(textColor: .label))
    @LazyInjected private var systemImageService: SystemImageService
    @LazyInjected private var toastService: ToastService

    // MARK: Initialization

    init() {
        super.init(title: L10n.Live.Feed.title)
    }

    // MARK: - State

    override func receiveState(_ state: LiveFeedViewModelState) {
        super.receiveState(state)
        CATransaction.begin()
        tableView.reloadData([state.liveFeed])
        CATransaction.setCompletionBlock { [self] in
            if tableView.hasRow(at: state.lastIndexPath) {
                tableView.scrollToRow(at: state.lastIndexPath, at: .bottom, animated: true)
            }
        }
        CATransaction.commit()
    }
}

// MARK: - Lifecycle

extension LiveFeedScreen {
    override func setupView() {
        super.setupView()
        setupWelcomeView()
        setupTableView()
        setupInputField()
        setupKeyboardObserving()
    }
}

// MARK: - Setups

extension LiveFeedScreen {
    private func setupWelcomeView() {
        let welcomeLabel = ButtonLabel(text: L10n.Live.Feed.Title.First.line, style: .label(textColor: .label)).then {
            view.addSubview($0)
            $0.anchorToSuperview(top: 16, leading: 16, trailing: -16, safeArea: true)
        }
        welcomeBottomView.then {
            view.addSubview($0)
            $0.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8).isActive = true
            $0.anchorToSuperview(leading: 16, trailing: -16, safeArea: true)
        }
    }

    private func setupTableView() {
        tableView.then {
            $0.delegate = self
            $0.separatorStyle = .none
            $0.allowsSelection = true

            $0.backgroundColor = .clear
            view.addSubview($0)
            $0.anchorToSuperview(leading: 16, trailing: -16, safeArea: true)
            $0.topAnchor.constraint(equalTo: welcomeBottomView.bottomAnchor, constant: 16).isActive = true
        }
    }

    private func setupInputField() {
        if UIApplication.hasNotch {
            additionalSafeAreaInsets = .init(top: .zero, left: .zero, bottom: 8, right: .zero)
        }
        inputField.then {
            view.addSubview($0)
            $0.anchorToSuperview(leading: .zero, trailing: .zero, safeArea: true)
            tableView.bottomAnchor.constraint(equalTo: $0.topAnchor, constant: -8).isActive = true
            bottomAnchor = $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).then {
                $0.isActive = true
            }
            $0.sendText = { [weak self] in
                self?.sendCommand(.sendMessage($0))
            }
        }
    }

    private func setupKeyboardObserving() {
        AnimatedKeyboardObserver
            .shared
            .beforeShowKeyboard
            .sink { [unowned self] in
                bottomAnchor?.isActive = false
                bottomAnchor = inputField
                    .bottomAnchor
                    .constraint(equalTo: view.bottomAnchor, constant: -(UIScreen.main.bounds.height - $0.1.minY))
                    .then { $0.isActive = true }
            }
            .store(in: &cancellables)

        AnimatedKeyboardObserver
            .shared
            .showingKeyboard
            .sink { [unowned self] _ in view.layoutIfNeeded() }
            .store(in: &cancellables)

        AnimatedKeyboardObserver
            .shared
            .beforeHideKeyboard
            .sink { [unowned self] in
                bottomAnchor?.isActive = false
                bottomAnchor = inputField
                    .bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                constant: -(UIScreen.main.bounds.height - $0.1.minY))
                    .then { $0.isActive = true }
            }
            .store(in: &cancellables)

        AnimatedKeyboardObserver
            .shared
            .hidingKeyboard
            .sink { [unowned self] _ in view.layoutIfNeeded() }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDelegate

extension LiveFeedScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        let message = self.tableView.data(for: indexPath).message
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying,
                                          previewProvider: nil) { [weak self] _ in
            guard let self else { return nil }
            return UIMenu(title: .init(), children: [self.shareAction(message: message),
                                                     self.copyAction(message: message)])
        }
    }

    func tableView(
        _ tableView: UITableView,
        previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        getTargetedPreview(for: configuration.identifier as? IndexPath)
    }

    func tableView(
        _ tableView: UITableView,
        previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        getTargetedPreview(for: configuration.identifier as? IndexPath)
    }
}

// MARK: - Private methods

extension LiveFeedScreen {
    private func getTargetedPreview(for indexPath: IndexPath?) -> UITargetedPreview? {
        guard let indexPath,
              let cell = tableView.cellForRow(at: indexPath) as? LiveFeedTableViewCell else { return nil }

        return UITargetedPreview(view: cell.targetedPreview,
                                 parameters: UIPreviewParameters().then { $0.backgroundColor = .clear })
    }

    private func shareAction(message: String) -> UIAction {
        .init(title: L10n.Live.Feed.share,
              image: systemImageService.image(symbol: .squareAndArrowUp),
              handler: { [weak self] _ in self?.share(message: message) })
    }

    private func copyAction(message: String) -> UIAction {
        .init(title: L10n.Live.Feed.copy,
              image: systemImageService.image(symbol: .docOnDoc),
              handler: { [weak self] _ in self?.sendCommand(.copy(message)) })
    }

    private func share(message: String) {
        let activityViewController = UIActivityViewController(activityItems: [message],
                                                              applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { [weak self] _, completed, _, error in
            if completed {
                self?.toastService.showToast(with: .init(message: L10n.Live.Feed.Share.success, type: .success))
            } else if let error {
                self?.toastService.showToast(with: .init(message: L10n.Live.Feed.Share.error(error),
                                                         type: .error))
            }
        }
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true)
    }
}
