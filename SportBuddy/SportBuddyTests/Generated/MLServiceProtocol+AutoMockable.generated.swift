// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import UIKit
@testable import SportBuddy

class MLServiceProtocolMock: MLServiceProtocol {

    //MARK: - init

    var initFromReceivedPoseDetectorMode: MLPoseDetectorMode?
    var initFromReceivedInvocations: [MLPoseDetectorMode] = []
    var initFromClosure: ((MLPoseDetectorMode) -> Void)?

    required init(from poseDetectorMode: MLPoseDetectorMode) {
        initFromReceivedPoseDetectorMode = poseDetectorMode
        initFromReceivedInvocations.append(poseDetectorMode)
        initFromClosure?(poseDetectorMode)
    }
    //MARK: - detect

    var detectForInSizeDestinationRectCallsCount = 0
    var detectForInSizeDestinationRectCalled: Bool {
        return detectForInSizeDestinationRectCallsCount > 0
    }
    var detectForInSizeDestinationRectReceivedArguments: (inputType: InputType, image: MLImage, size: CGSize, destinationRect: CGRect)?
    var detectForInSizeDestinationRectReceivedInvocations: [(inputType: InputType, image: MLImage, size: CGSize, destinationRect: CGRect)] = []
    var detectForInSizeDestinationRectReturnValue: [BoneEndpoint]!
    var detectForInSizeDestinationRectClosure: ((InputType, MLImage, CGSize, CGRect) -> [BoneEndpoint])?

    func detect(for inputType: InputType, in image: MLImage, size: CGSize, destinationRect: CGRect) -> [BoneEndpoint] {
        detectForInSizeDestinationRectCallsCount += 1
        detectForInSizeDestinationRectReceivedArguments = (inputType: inputType, image: image, size: size, destinationRect: destinationRect)
        detectForInSizeDestinationRectReceivedInvocations.append((inputType: inputType, image: image, size: size, destinationRect: destinationRect))
        return detectForInSizeDestinationRectClosure.map({ $0(inputType, image, size, destinationRect) }) ?? detectForInSizeDestinationRectReturnValue
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
