//
//  SettingsItem.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import Foundation

struct SettingsItem {
    // MARK: Nested types

    enum Toggle {
        case on
        case off
        case none
    }

    // MARK: Properties

    let id: UUID
    let title: String
    let subtitle: String
    let toggle: Toggle
    let action: () -> Void

    // MARK: Initialization

    init(id: UUID = .init(),
         title: String,
         subtitle: String = .init(),
         toggle: Toggle = .none,
         action: @escaping () -> Void = { }) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.toggle = toggle
        self.action = action
    }
}

extension SettingsItem: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
