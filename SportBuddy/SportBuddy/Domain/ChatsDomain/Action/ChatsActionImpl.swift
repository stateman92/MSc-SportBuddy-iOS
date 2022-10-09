//
//  ChatsActionImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsActionImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var chatsCache: ChatsCache
    @LazyInjected private var webSocketService: WebSocketService
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var coderService: CoderService
    @LazyInjected private var userImageCache: UserImageCache

    // MARK: Initialization

    override init() {
        super.init()
        webSocketService.receivedText
            .compactMap { [unowned self] text -> ChatDTO? in coderService.decode(string: text) }
            .sink { [unowned self] chat in
                var chats = (chatsCache.immediateValue ?? .init(chats: [])).chats
                chats.removeAll { $0.primaryId == chat.primaryId }
                chats.append(chat)
                chatsCache.save(item: .init(chats: chats))

                let id = chat.primaryId
                if userImageCache.immediateValue?.images[id] == nil {
                    deferredFutureOnMainLoading(blocking: false) { [unowned self] () -> DomainActionResult<Void> in
                        do {
                            let image = try await ClientAPI.userImageGet(chatId: id.uuidString)
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
            }
            .store(in: &cancellables)
    }
}

// MARK: - ChatsAction

extension ChatsActionImpl: ChatsAction {
    func getChats() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<[ChatDTO]> in
            do {
                let results = try await ClientAPI.chatEntriesGet()
                chatsCache.save(item: .init(chats: results))
                return .success(results)
            } catch {
                return .failure(error)
            }
        }
    }
}
