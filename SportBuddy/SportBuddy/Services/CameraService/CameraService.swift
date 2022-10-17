//
//  CameraService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import AVFoundation
import Combine

/// A protocol for handling the camera.
protocol CameraService: Initable, AutoMockable {
    /// Set the preview layer for the camera.
    /// - Parameters:
    ///   - videoPreviewLayer: the preview layer.
    func set(videoPreviewLayer: AVCaptureVideoPreviewLayer)

    /// Call to get a callback for each recogized states.
    /// - Parameters:
    ///   - completion: the callback.
    func skeletonShouldUpdate(completion: @escaping ([BoneEndpoint]) -> Void)

    /// Stop the service.
    func stop()

    /// Change the camera (front - rear mode).
    func changeCamera()
}

extension CameraService {
    /// Set the preview view for the camera.
    /// - Parameters:
    ///   - cameraView: the preview view.
    func set(cameraView: CameraView) {
        set(videoPreviewLayer: cameraView.videoPreviewLayer)
    }

    /// Call to get a result for each recogized states.
    /// - Returns:
    ///     The sequence of endpoints.
    func skeletonShouldUpdate() -> AsyncStream<[BoneEndpoint]> {
        .init {
            skeletonShouldUpdate { [continuation = $0] in
                continuation.yield($0)
            }
        }
    }

    /// Call to get a result for each recogized states.
    /// - Returns:
    ///     The sequence of endpoints.
    func skeletonShouldUpdate() -> AnyPublisher<[BoneEndpoint], Never> {
        let subject = PassthroughSubject<[BoneEndpoint], Never>()
        skeletonShouldUpdate {
            subject.send($0)
        }
        return subject.autoEraseOnMain()
    }
}
