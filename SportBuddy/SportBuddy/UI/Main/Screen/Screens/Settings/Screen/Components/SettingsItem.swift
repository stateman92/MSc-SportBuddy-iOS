//
//  SettingsItem.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import Foundation

struct SettingsItem {
    // MARK: Nested types

    enum Details: Equatable {
        case toggle(Toggle, action: (Bool) -> Void)
        case segments([Segment], action: (Segment) -> Void)
        case button(String, action: () -> Void)
        case none

        static func == (lhs: SettingsItem.Details, rhs: SettingsItem.Details) -> Bool {
            switch (lhs, rhs) {
            case (let .toggle(lhsToggle, _), let .toggle(rhsToggle, _)): return lhsToggle == rhsToggle
            case (let .segments(lhsSegments, _), let .segments(rhsSegments, _)): return lhsSegments == rhsSegments
            case (let .button(lhsTitle, _), let .button(rhsTitle, _)): return lhsTitle == rhsTitle
            case (.none, .none): return true
            default: return false
            }
        }
    }

    enum Toggle {
        case on
        case off
    }

    struct Segment: Equatable {
        let id: String
        let title: String
        let selected: Bool
    }

    // MARK: Properties

    let id: UUID
    let title: String
    let subtitle: String
    let details: Details
    let action: () -> Void

    // MARK: Initialization

    init(id: UUID = .init(),
         title: String,
         subtitle: String = .init(),
         details: Details = .none,
         action: @escaping () -> Void = { }) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.details = details
        self.action = action
    }
}

extension SettingsItem: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
