//
//  ChatType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

import Foundation

enum ChatType {
    case existing(ChatDTO)
    case new(chatId: UUID, recipientId: UUID)
}

// MARK: - Properties

extension ChatType {
    var id: UUID {
        switch self {
        case let .existing(chatDto): return chatDto.primaryId
        case let .new(chatId, _): return chatId
        }
    }

    var text: String {
        switch self {
        case .existing: return "Existing chat!"
        case .new: return "New chat!"
        }
    }
}

// MARK: - Public methods

extension ChatType {
    func recipient(_ userCache: UserCache) -> UUID? {
        guard let userId = userCache.immediateValue?.primaryId else {
            assertionFailure("User's id didn't find!")
            return nil
        }
        switch self {
        case let .existing(chatDto): return chatDto.users.first { $0 != userId }
        case let .new(_, recipientId): return recipientId
        }
    }
}
