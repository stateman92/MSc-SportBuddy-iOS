//
//  VideoPlayerView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import Combine
import YouTubeiOSPlayerHelper

final class VideoPlayerView: View {
    // MARK: Properties

    private var id: String?
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
        setupYoutubeView()
    }

    private func setupYoutubeView() {
        youtubeView.then {
            addSubview($0)
            $0.delegate = self
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}

// MARK: - YTPlayerViewDelegate

extension VideoPlayerView: YTPlayerViewDelegate {
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        id.map(load(id:))
    }

    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        playerView.webView?.evaluateJavaScript("player.mute();")
    }
}

// MARK: - Public methods

extension VideoPlayerView {
    func load(id: String) {
        self.id = id
        youtubeView.load(withVideoId: id, playerVars: [
            "controls": 0, // remove controls
            "fs": 0, // remove full screen button
            "loop": 1, // looping the video
            "playlist": id, // looping the video (iframe workaround)
            "autoplay": 1, // start the video automatically
            "modestbranding": 1 // remove big logo
        ])
    }
}
