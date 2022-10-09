// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class NotificationServiceMock: NotificationService {

    //MARK: - sendNotification

    var sendNotificationTitleSubtitleSoundTimingCallsCount = 0
    var sendNotificationTitleSubtitleSoundTimingCalled: Bool {
        return sendNotificationTitleSubtitleSoundTimingCallsCount > 0
    }
    var sendNotificationTitleSubtitleSoundTimingReceivedArguments: (title: String, subtitle: String?, sound: UNNotificationSound?, timing: NotificationTiming)?
    var sendNotificationTitleSubtitleSoundTimingReceivedInvocations: [(title: String, subtitle: String?, sound: UNNotificationSound?, timing: NotificationTiming)] = []
    var sendNotificationTitleSubtitleSoundTimingClosure: ((String, String?, UNNotificationSound?, NotificationTiming) -> Void)?

    func sendNotification(title: String, subtitle: String?, sound: UNNotificationSound?, timing: NotificationTiming) {
        sendNotificationTitleSubtitleSoundTimingCallsCount += 1
        sendNotificationTitleSubtitleSoundTimingReceivedArguments = (title: title, subtitle: subtitle, sound: sound, timing: timing)
        sendNotificationTitleSubtitleSoundTimingReceivedInvocations.append((title: title, subtitle: subtitle, sound: sound, timing: timing))
        sendNotificationTitleSubtitleSoundTimingClosure?(title, subtitle, sound, timing)
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
