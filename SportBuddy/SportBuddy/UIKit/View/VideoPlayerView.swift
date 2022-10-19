//
//  VideoPlayerView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import YouTubeiOSPlayerHelper

final class VideoPlayerView: View {
    // MARK: Properties

    private let youtubeView = YTPlayerView()

    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension VideoPlayerView {
    private func setupView() {
        youtubeView.delegate = self
    }
}

// MARK: - YTPlayerViewDelegate

extension VideoPlayerView: YTPlayerViewDelegate {
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        playerView.webView?.evaluateJavaScript("player.mute();")
    }
}

// MARK: - Public methods

extension VideoPlayerView {
    func load(id: String) {
        youtubeView.load(withVideoId: id)
        youtubeView.stopVideo()
    }
}
