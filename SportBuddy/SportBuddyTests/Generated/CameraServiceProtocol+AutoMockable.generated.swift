// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class CameraServiceProtocolMock: CameraServiceProtocol {

    //MARK: - set

    var setVideoPreviewLayerCallsCount = 0
    var setVideoPreviewLayerCalled: Bool {
        return setVideoPreviewLayerCallsCount > 0
    }
    var setVideoPreviewLayerReceivedVideoPreviewLayer: AVCaptureVideoPreviewLayer?
    var setVideoPreviewLayerReceivedInvocations: [AVCaptureVideoPreviewLayer] = []
    var setVideoPreviewLayerClosure: ((AVCaptureVideoPreviewLayer) -> Void)?

    func set(videoPreviewLayer: AVCaptureVideoPreviewLayer) {
        setVideoPreviewLayerCallsCount += 1
        setVideoPreviewLayerReceivedVideoPreviewLayer = videoPreviewLayer
        setVideoPreviewLayerReceivedInvocations.append(videoPreviewLayer)
        setVideoPreviewLayerClosure?(videoPreviewLayer)
    }

    //MARK: - skeletonShouldUpdate

    var skeletonShouldUpdateCompletionCallsCount = 0
    var skeletonShouldUpdateCompletionCalled: Bool {
        return skeletonShouldUpdateCompletionCallsCount > 0
    }
    var skeletonShouldUpdateCompletionReceivedCompletion: (([BoneEndpoint]) -> Void)?
    var skeletonShouldUpdateCompletionReceivedInvocations: [(([BoneEndpoint]) -> Void)] = []
    var skeletonShouldUpdateCompletionClosure: ((@escaping ([BoneEndpoint]) -> Void) -> Void)?

    func skeletonShouldUpdate(completion: @escaping ([BoneEndpoint]) -> Void) {
        skeletonShouldUpdateCompletionCallsCount += 1
        skeletonShouldUpdateCompletionReceivedCompletion = completion
        skeletonShouldUpdateCompletionReceivedInvocations.append(completion)
        skeletonShouldUpdateCompletionClosure?(completion)
    }

    //MARK: - stop

    var stopCallsCount = 0
    var stopCalled: Bool {
        return stopCallsCount > 0
    }
    var stopClosure: (() -> Void)?

    func stop() {
        stopCallsCount += 1
        stopClosure?()
    }

    //MARK: - changeCamera

    var changeCameraCallsCount = 0
    var changeCameraCalled: Bool {
        return changeCameraCallsCount > 0
    }
    var changeCameraClosure: (() -> Void)?

    func changeCamera() {
        changeCameraCallsCount += 1
        changeCameraClosure?()
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
