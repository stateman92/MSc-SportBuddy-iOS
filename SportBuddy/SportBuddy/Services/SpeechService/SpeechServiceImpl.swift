//
//  SpeechServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import AVFoundation

/// A class for handling the text-to-speech.
final class SpeechServiceImpl {
    // MARK: Properties

    private let speechSynthesizer = AVSpeechSynthesizer.create()
    private weak var delegate: AVSpeechSynthesizerDelegate?
}

// MARK: - SpeechService

extension SpeechServiceImpl: SpeechService {
    func read(text: String, language: AVSpeechSynthesizer.Language) {
        delegate = speechSynthesizer.read(text: text, language: language)
    }
}
