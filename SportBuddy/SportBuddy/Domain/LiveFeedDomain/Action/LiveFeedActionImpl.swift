//
//  LiveFeedActionImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class LiveFeedActionImpl: DomainImpl {
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var liveFeedCache: LiveFeedCache
    @LazyInjected private var webSocketService: WebSocketService
    @LazyInjected private var coderService: CoderService

    override init() {
        super.init()
        webSocketService.receivedText
            .compactMap { [unowned self] text -> LiveFeedResponseDTO? in coderService.decode(string: text) }
            .sink { [unowned self] liveFeedDto in
                var liveFeedDtos = liveFeedCache.immediateValue?.liveFeeds ?? []
                liveFeedDtos.append(liveFeedDto)
                liveFeedCache.save(item: .init(liveFeeds: liveFeedDtos))
            }
            .store(in: &cancellables)
    }
}

// MARK: - LiveFeedAction

extension LiveFeedActionImpl: LiveFeedAction {
    func sendText(message: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { [unowned self] () -> DomainActionResult<Void> in
            guard let userId = userCache.immediateValue?.user.primaryId else {
                assertionFailure("User's id didn't find!")
                return .success(())
            }
            webSocketService.send(LiveFeedDTO(sender: userId, message: message, date: .init()))
            return .success(())
        }
    }
}
