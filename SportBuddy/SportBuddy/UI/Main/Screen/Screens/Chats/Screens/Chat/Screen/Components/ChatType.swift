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
        case .existing: return L10n.Chat.Types.new
        case .new: return L10n.Chat.Types.existing
        }
    }
}

// MARK: - Public methods

extension ChatType {
    func recipient(_ userId: UUID) -> UUID? {
        switch self {
        case let .existing(chatDto): return chatDto.users.first { $0 != userId }
        case let .new(_, recipientId): return recipientId
        }
    }
}
