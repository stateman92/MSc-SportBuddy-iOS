//
//  GroupsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

// swiftlint:disable:next colon
final class GroupsScreen:
    TabScreen<GroupsViewModelState, GroupsViewModelCommand, GroupsDomainImpl, GroupsViewModel> {
    // MARK: Initialization

    init() {
        super.init(title: "Groups")
    }
}
