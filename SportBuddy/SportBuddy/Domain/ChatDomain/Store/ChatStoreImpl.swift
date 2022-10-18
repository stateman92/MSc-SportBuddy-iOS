//
//  ChatStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

final class ChatStoreImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var chatsCache: ChatsCache
    @LazyInjected private var tokenCache: TokenCache
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var userImageCache: UserImageCache
}

// MARK: - ChatStore

extension ChatStoreImpl: ChatStore {
    func getChat(id: UUID) -> DomainStorePublisher<ChatDTO> {
        if userImageCache.immediateValue?.images[id] == nil {
            deferredFutureOnMainLoading(blocking: false) { [unowned self] () -> DomainActionResult<Void> in
                do {
                    let image = try await BackendAPI.userImageGet(chatId: id.uuidString)
                    var currentValue = userImageCache.immediateValue ?? .init(images: [:])
                    currentValue.images[id] = image
                    userImageCache.save(item: currentValue)
                    return .success(())
                } catch {
                    return .failure(error)
                }
            }
            .sink()
            .store(in: &cancellables)
        }

        return chatsCache.value().map(\.?.chats).map { $0?.first { $0.primaryId == id } }.autoEraseOnMain()
    }

    func getUser() -> DomainStorePublisher<UserDTO> {
        userCache.value().compactMap(\.?.user).autoEraseOnMain()
    }

    func getImage(for chatId: UUID) -> DomainStorePublisher<String> {
        userImageCache.value().compactMap(\.?.images[chatId]).autoEraseOnMain()
    }

    var immediateToken: UUID? {
        tokenCache.immediateValue?.token
    }
}
