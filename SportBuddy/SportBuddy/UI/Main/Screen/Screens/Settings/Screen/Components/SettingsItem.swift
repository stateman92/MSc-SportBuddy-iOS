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
        case toggle(Toggle, performActionForSelection: Bool = false, action: (Bool) -> Void)
        case segments([Segment], performActionForSelection: Bool = false, action: (Segment) -> Void)
        case button(String, performActionForSelection: Bool = false, action: () -> Void)
        case none

        static func == (lhs: SettingsItem.Details, rhs: SettingsItem.Details) -> Bool {
            switch (lhs, rhs) {
            case (let .toggle(lhsToggle, _, _), let .toggle(rhsToggle, _, _)): return lhsToggle == rhsToggle
            case (let .segments(lhsSegments, _, _), let .segments(rhsSegments, _, _)): return lhsSegments == rhsSegments
            case (let .button(lhsTitle, _, _), let .button(rhsTitle, _, _)): return lhsTitle == rhsTitle
            case (.none, .none): return true
            default: return false
            }
        }

        var performActionForSelection: Bool {
            switch self {
            case let .toggle(_, performActionForSelection, _): return performActionForSelection
            case let .segments(_, performActionForSelection, _): return performActionForSelection
            case let .button(_, performActionForSelection, _): return performActionForSelection
            case .none: return true
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
