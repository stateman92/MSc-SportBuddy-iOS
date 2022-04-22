//
//  CameraService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import AVFoundation
import Photos
import UIKit

/// A class for handling the camera.
final class CameraService {
    // MARK: Properties

    private let captureSession = AVCaptureSession()
    private let dataOutput = AVCaptureVideoDataOutput(alwaysDiscardsLateVideoFrames: true)
    private let dataOutputQueue = DispatchQueue(label: "dataOutputQueue")
    private let photoOutput = AVCapturePhotoOutput()
    private var videoSize = CGSize(width: 1080, height: 1920)
    private var isBackCameraInOperation = true
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var skeletonShouldUpdated: ([BoneEndpoint]) -> Void = { _ in }
    @LazyInjected private var mlService: MLServiceProtocol
}

// MARK: - CameraServiceProtocol

extension CameraService: CameraServiceProtocol {
    /// Set the preview layer for the camera.
    /// - Parameters:
    ///   - videoPreviewLayer: the preview layer.
    func set(videoPreviewLayer: AVCaptureVideoPreviewLayer) {
        runOnDevice {
            self.videoPreviewLayer = videoPreviewLayer
            self.videoPreviewLayer?.session = captureSession
            requestPermission()
        }
    }

    /// Call to get a callback for each recogized states.
    /// - Parameters:
    ///   - completion: the callback.
    func skeletonShouldUpdate(completion: @escaping ([BoneEndpoint]) -> Void) {
        runOnDevice {
            self.skeletonShouldUpdated = completion
        }
    }

    /// Stop the service.
    func stop() {
        runOnDevice {
            captureSession.stopRunning()
        }
    }

    /// Change the camera (front - rear mode).
    func changeCamera() {
        runOnDevice {
            skeletonShouldUpdated([])
            isBackCameraInOperation.toggle()
            setup()
        }
    }
}

// MARK: - Private methods

extension CameraService {
    private func getBoneEndpoints(from image: MLImage) -> [BoneEndpoint] {
        mlService.detect(for: .movie(isMirroring: !isBackCameraInOperation),
                         in: image,
                         size: videoSize,
                         destinationRect: UIScreen.main.bounds)
    }

    private func requestPermission() {
        func accessDenied() {
        }

        AVCaptureDevice.requestPermission { [weak self] in
            self?.setup()
        } denied: {
            accessDenied()
        }
    }

    private func setup() {
        captureSession.stopIfRunning()
        captureSession.reset()
        captureSession.configure { _ in
            setupCamera()
        }
        captureSession.startRunning()
    }

    private func setupCamera() {
        guard let videoDeviceInput = AVCaptureDeviceInput(
            device: .default(.builtInWideAngleCamera, for: .video, position: isBackCameraInOperation ? .back : .front)),
              captureSession.tryToAdd(input: videoDeviceInput),
              captureSession.tryToAdd(output: dataOutput),
              captureSession.tryToSet(preset: .iFrame960x540),
              captureSession.tryToAdd(output: photoOutput)
        else {
            return
        }

        videoSize = videoDeviceInput.size
        videoDeviceInput.device.configure { $0.tryToSet(focusMode: .continuousAutoFocus) }

        dataOutput.connections.first?.isVideoMirrored = !isBackCameraInOperation
        dataOutput.setSampleBufferDelegate(on: dataOutputQueue) { [weak self] in
            guard let self = self else { return }
            self.skeletonShouldUpdated(self.getBoneEndpoints(from: .buffer($0)))
        }
    }
}
