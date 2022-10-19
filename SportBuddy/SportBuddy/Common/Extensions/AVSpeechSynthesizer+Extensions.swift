//
//  AVSpeechSynthesizer+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import AVKit

extension AVSpeechSynthesizer {
    final private class SpeechSynthesizerDelegate: NSObject, AVSpeechSynthesizerDelegate {
        fileprivate var didStart: () -> Void
        fileprivate var didFinish: () -> Void

        /// Create a `SpeechSynthesizerDelegate`.
        /// - Parameters:
        ///   - didStart: the closure that runs if the speech did start.
        ///   - didFinish: the closure that runs if the speech did finish.
        fileprivate init(didStart: @escaping () -> Void = { }, didFinish: @escaping () -> Void = { }) {
            self.didStart = didStart
            self.didFinish = didFinish
            super.init()
        }

        func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
            didStart()
        }

        func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
            didFinish()
        }
    }

    /// Create an `AVSpeechSynthesizer`.
    class func create() -> AVSpeechSynthesizer {
        let speechSynthesizer = AVSpeechSynthesizer()
        try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
        try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        return speechSynthesizer
    }

    /// Languages for speaking.
    enum Language: String {
        case en = "en-US"
        case hu = "hu-HU"
    }

    /// Speed for speaking.
    enum SpeechSpeed {
        case minimum
        case maximum
        case `default`
        case rate(speed: Float)

        /// Speed rate of the speaking.
        /// - Note:
        /// This value is always valid.
        fileprivate var rate: Float {
            switch self {
            case .minimum: return AVSpeechUtteranceMinimumSpeechRate
            case .maximum: return AVSpeechUtteranceMaximumSpeechRate
            case .default: return AVSpeechUtteranceDefaultSpeechRate
            case let .rate(speed):
                if speed < SpeechSpeed.minimum.rate {
                    return SpeechSpeed.minimum.rate
                } else if speed > SpeechSpeed.maximum.rate {
                    return SpeechSpeed.maximum.rate
                } else {
                    return speed
                }
            }
        }
    }
}

extension AVSpeechSynthesizer {
    /// Read a text with TTS (Text-To-Speech).
    /// - Parameters:
    ///   - text: the text to read.
    ///   - language: the language of the TTS.
    ///   - speed: the speed of the TTS. By default `.default`.
    ///   - volume: the volume of the TTS. By default `1`.
    ///   - didStart: the closure that runs if the speech did start. By default does nothing.
    ///   - didFinish: the closure that runs if the speech did finish. By default does nothing.
    func read(text: String,
              language: Language,
              speed: SpeechSpeed = .default,
              volume: Float = 1,
              didStart: @escaping () -> Void = { },
              didFinish: @escaping () -> Void = { }) -> AVSpeechSynthesizerDelegate {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language.rawValue)
        utterance.rate = speed.rate
        utterance.volume = max(min(1, volume), 0)

        defer {
            speak(utterance)
        }
        if let delegate = delegate as? SpeechSynthesizerDelegate {
            delegate.didStart = didStart
            delegate.didFinish = didFinish
            return delegate
        } else {
            let delegate = SpeechSynthesizerDelegate(didStart: didStart, didFinish: didFinish)
            self.delegate = delegate
            return delegate
        }
    }
}
