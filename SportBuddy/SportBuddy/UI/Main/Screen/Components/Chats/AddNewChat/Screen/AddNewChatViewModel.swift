//
//  AddNewChatViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import Foundation

final class AddNewChatViewModel: BaseViewModel {
    // MARK: Properties

    @Published private(set) var users: [UserDTO] = []
    @Throttling(seconds: 0.66) var searchTerm: String = .init()
    var didSelectRecipient: ((UUID) -> Void)?

    // MARK: Initialization

    override init() {
        super.init()
        setup()
    }
}

// MARK: - Setups

extension AddNewChatViewModel {
    private func setup() {
        userStore
            .searchedUser
            .sink { [unowned self] in users = $0 }
            .store(in: &cancellables)

        $searchTerm.on { [weak self] in self?.searchTermDidChange($0) }
    }
}

// MARK: - Helpers

extension AddNewChatViewModel {
    private func searchTermDidChange(_ searchTerm: String) {
        userAction.searchUsers(searchTerm: searchTerm).sink().store(in: &cancellables)
    }
}

// MARK: - Public methods

extension AddNewChatViewModel {
    func didSelect(id: UUID) {
        navigatorService.navigateBack()
        didSelectRecipient?(id)
        userAction.clearSearchedUser().sink().store(in: &cancellables)
    }
}
