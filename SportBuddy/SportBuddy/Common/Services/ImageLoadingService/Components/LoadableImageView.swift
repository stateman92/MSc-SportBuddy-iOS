//
//  LoadableImageView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 10..
//

import Kingfisher
import UIKit

final class LoadableImageView: ImageView {
    // MARK: Initialization

    override init() {
        super.init()
        setupUI()
    }
}

// MARK: - Setups

extension LoadableImageView {
    private func setupUI() {
        kf.indicatorType = .activity
    }
}

// MARK: - Public methods

extension LoadableImageView {
    /// Load an image from an url.
    /// - Parameter url: the url from which the image will be loaded.
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        kf.setImage(with: ImageResource(downloadURL: url),
                    options: [.transition(.fade(0.25)), .cacheMemoryOnly])
    }

    /// Cancel the image loading on this image view.
    func cancelImageLoading() {
        kf.cancelDownloadTask()
    }
}
