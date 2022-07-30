//
//  ImageLoadingServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 10..
//

import Foundation
import Kingfisher

/// A class for loading the images.
final class ImageLoadingServiceImpl {
    // MARK: Initialization

    /// Initialize the service.
    init() { }
}

// MARK: - ImageLoadingService

extension ImageLoadingServiceImpl: ImageLoadingService {
    /// Load an image from an url.
    /// - Parameters:
    ///   - url: the url from which the image will be loaded.
    ///   - view: the image view.
    func load(url: URL, in view: ImageView) {
        view.kf.setImage(with: ImageResource(downloadURL: url),
                         options: [.transition(.fade(0.25)), .cacheMemoryOnly])
    }

    /// Cancel the image loading on this image view.
    /// - Parameter view: the image view.
    func cancelImageLoading(in view: ImageView) {
        view.kf.cancelDownloadTask()
    }
}
