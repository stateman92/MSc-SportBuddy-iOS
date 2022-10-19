//
//  SpeechService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import AVFoundation

/// A protocol for handling the text-to-speech.
protocol SpeechService: Initable, AutoMockable {
    /// Read out loud some texts.
    /// - Parameters:
    ///   - text: the text to be read.
    ///   - language: the language of the text-to-speech.
    func read(text: String, language: AVSpeechSynthesizer.Language)
}
