//
//  ImageLoadingService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 10..
//

import Foundation

/// A protocol for loading the images.
protocol ImageLoadingService: Initable, AutoMockable {
    /// Load an image from an url.
    /// - Parameters:
    ///   - url: the url from which the image will be loaded.
    ///   - view: the image view.
    func load(url: URL, in view: ImageView)

    /// Cancel the image loading on this image view.
    /// - Parameter view: the image view.
    func cancelImageLoading(in view: ImageView)
}

extension ImageLoadingService {
    /// Load an image from an url.
    /// - Parameters:
    ///   - url: the url from which the image will be loaded.
    ///   - view: the image view.
    func load(url: String, in view: ImageView) {
        guard let url = URL(string: url) else { return }
        load(url: url, in: view)
    }
}
