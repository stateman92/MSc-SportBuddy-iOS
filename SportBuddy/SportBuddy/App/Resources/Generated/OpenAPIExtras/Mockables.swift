//
//  Mockables.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Foundation

protocol Mockable {
    static var mock: Self { get }
}

extension Int: Mockable {
    static var mock: Self {
        5
    }
}

extension Bool: Mockable {
    static var mock: Self {
        true
    }
}

extension String: Mockable {
    static var mock: Self {
        "mockString"
    }
}

extension Array where Element: Mockable {
    static var mock: Self {
        [.mock, .mock]
    }
}

extension UUID: Mockable {
    static var mock: Self {
        .init()
    }
}

extension UserResponseDTO: Mockable {
    static var mock: Self {
        .init(token: .mock, user: .mock)
    }
}

extension UserDTO: Mockable {
    static var mock: Self {
        .init(primaryId: .mock, name: .mock, email: .mock, profileImage: .mock, bio: .mock, chats: .mock)
    }
}

extension ChatDTO: Mockable {
    static var mock: Self {
        .init(chatEntries: .mock, image: .mock, primaryId: .mock, users: .mock, otherParty: .init())
    }
}

extension ChatEntryDTO: Mockable {
    static var mock: Self {
        .init(primaryId: .mock, message: .mock, timestamp: .mock, sender: .mock, deleted: .mock)
    }
}

extension LiveFeedDTO: Mockable {
    static var mock: Self {
        .init(sender: .mock, message: .mock, date: .mock)
    }
}

extension LiveFeedResponseDTO: Mockable {
    static var mock: Self {
        .init(image: .mock, message: .mock, date: .mock)
    }
}

extension Date: Mockable {
    static var mock: Self {
        .init(secondsSince1970: 32000)
    }
}

extension LanguageSettings: Mockable {
    static var mock: Self {
        .system
    }
}
