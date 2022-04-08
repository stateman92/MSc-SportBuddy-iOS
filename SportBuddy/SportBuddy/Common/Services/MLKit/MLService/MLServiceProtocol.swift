//
//  MLServiceProtocol.swift
//  GoogleMLKitPoseDetection
//
//  Created by Kristof Kalai on 2022. 04. 06..
//

import CoreGraphics

protocol MLServiceProtocol: AutoMockable {
    /// Create a service.
    /// - Parameters:
    ///   - from: the mode of the detector service.
    init(from poseDetectorMode: MLPoseDetectorMode)

    /// Detect the endpoints.
    /// - Parameters:
    ///   - for: the input type.
    ///   - in: the image to search for endpoints in.
    ///   - size: the size of the image.
    ///   - destinationRect: the rectangle of the destination.
    /// - Returns:
    ///     The endpoints.
    func detect(for inputType: InputType, in image: MLImage, size: CGSize, destinationRect: CGRect) -> [BoneEndpoint]
}

extension MLServiceProtocol {
    /// Create a service with `.singleImage` detector mode.
    init() {
        self.init(from: .singleImage)
    }

    /// Detect the endpoints from a `.photo` input type.
    /// - Parameters:
    ///   - in: the image to search for endpoints in.
    ///   - size: the size of the image.
    ///   - destinationRect: the rectangle of the destination.
    /// - Returns:
    ///     The endpoints.
    func detect(in image: MLImage, size: CGSize, destinationRect: CGRect) -> [BoneEndpoint] {
        detect(for: .photo, in: image, size: size, destinationRect: destinationRect)
    }
}
