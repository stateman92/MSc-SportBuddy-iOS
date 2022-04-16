//
//  MLService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 06..
//

import MLKit

/// A class for managing the body recognition.
final class MLService: AutoMockable {
    // MARK: Properties

    private let poseDetector: PoseDetector

    // MARK: Initialization

    /// Initialize the service.
    /// - Parameters:
    ///   - from: the mode of the detector service.
    init(from poseDetectorMode: MLPoseDetectorMode) {
        poseDetector = .poseDetector(mode: poseDetectorMode.accuratePoseDetectorOptions)
    }
}

// MARK: - MLServiceProtocol

extension MLService: MLServiceProtocol {
    /// Detect the endpoints.
    /// - Parameters:
    ///   - for: the input type.
    ///   - in: the image to search for endpoints in.
    ///   - size: the size of the image.
    ///   - destinationRect: the rectangle of the destination.
    /// - Returns:
    ///     The endpoints.
    func detect(for inputType: InputType,
                in image: MLImage,
                size: CGSize,
                destinationRect rect: CGRect) -> [BoneEndpoint] {
        poseDetector.detect(for: inputType, visionImage: image.visionImage, size: size, destinationRect: rect)
    }
}

// MARK: - Private extensions

extension Array where Element: Pose {
    /// Get the poses as landmarks.
    private var landmarks: [MLPoseLandmark] {
        flatMap(\.landmarks).map(MLPoseLandmark.init(poseLandmark:))
    }

    /// Get the poses as bone endpoints.
    /// - Parameters:
    ///   - for: the input type.
    ///   - size: the size.
    ///   - destinationRect: the rectangle of the destination.
    fileprivate func getBoneEndpoints(for inputType: InputType,
                                      size: CGSize,
                                      destinationRect: CGRect) -> [BoneEndpoint] {
        landmarks.map {
            BoneEndpoint(inputType: inputType, poseLandmark: $0, size: size, destinationRect: destinationRect)
        }
    }
}

extension AccuratePoseDetectorOptions {
    /// Create a detector that waits for a streaming images.
    fileprivate static var stream: AccuratePoseDetectorOptions {
        AccuratePoseDetectorOptions(mode: .stream)
    }

    /// Create a detector that waits for single images.
    fileprivate static var singleImage: AccuratePoseDetectorOptions {
        AccuratePoseDetectorOptions(mode: .singleImage)
    }

    /// Create an options object.
    /// - Parameters:
    ///   - mode: the pose detector mode.
    private convenience init(mode: MLPoseDetectorMode) {
        self.init()
        detectorMode = mode.poseDetectorMode
    }
}

extension PoseDetector {
    /// Create a detector.
    /// - Parameters:
    ///   - mode: the pose detector mode.
    /// - Returns:
    ///     The pose detector.
    fileprivate static func poseDetector(mode: AccuratePoseDetectorOptions) -> PoseDetector {
        .poseDetector(options: mode)
    }

    /// Get the screen coordinates of a landmark.
    /// - Parameters:
    ///   - for: the input type.
    ///   - size: the size.
    ///   - destinationRect: the rectangle of the destination.
    /// - Returns:
    ///     The screen coordinates.
    fileprivate func detect(for inputType: InputType,
                            visionImage: VisionImage,
                            size: CGSize,
                            destinationRect: CGRect) -> [BoneEndpoint] {
        results(from: visionImage)?.getBoneEndpoints(for: inputType, size: size, destinationRect: destinationRect) ?? []
    }

    /// Get the results of the image detection.
    /// - Parameters:
    ///   - from: the input image.
    /// - Returns:
    ///     The results, or `nil` if it cannot be recognized.
    private func results(from visionImage: VisionImage) -> [Pose]? {
        try? results(in: visionImage)
    }
}

extension MLPoseLandmark {
    /// Create a landmark from a pose landmark.
    /// - Parameters:
    ///   - poseLandmark: the pose landmark.
    fileprivate init(poseLandmark: PoseLandmark) {
        type = MLPoseLandmarkType(poseLandmark: poseLandmark.type)
        position = CGPoint(x: poseLandmark.position.x, y: poseLandmark.position.y)
    }
}

extension MLImage {
    /// Get the image as `VisionImage`.
    fileprivate var visionImage: VisionImage {
        switch self {
        case let .image(image): return .init(image: image)
        case let .buffer(buffer): return .init(buffer: buffer)
        }
    }
}

extension BoneEndpoint {
    /// Create a bone endpoint.
    /// - Parameters:
    ///   - inputType: the input type.
    ///   - poseLandmark: the pose landmark.
    ///   - size: the size.
    ///   - destinationRect: the rectangle of the destination.
    fileprivate init(inputType: InputType, poseLandmark: MLPoseLandmark, size: CGSize, destinationRect rect: CGRect) {
        self.init(type: poseLandmark.type,
                  coordinate: poseLandmark.getScreenCoordinates(for: inputType, size: size, destinationRect: rect))
    }
}

extension MLPoseDetectorMode {
    /// Get the mode as `AccuratePoseDetectorOptions`.
    fileprivate var accuratePoseDetectorOptions: AccuratePoseDetectorOptions {
        switch self {
        case .singleImage: return .singleImage
        case .stream: return .stream
        }
    }

    /// Get the mode as `PoseDetectorMode`.
    fileprivate var poseDetectorMode: PoseDetectorMode {
        switch self {
        case .singleImage: return .singleImage
        case .stream: return .stream
        }
    }
}

extension MLPoseLandmarkType {
    /// Get the landmark type as `PoseLandmarkType`.
    fileprivate var poseLandmarkType: PoseLandmarkType {
        switch self {
        case .nose: return .nose
        case .leftEyeInner: return .leftEyeInner
        case .leftEye: return .leftEye
        case .leftEyeOuter: return .leftEyeOuter
        case .rightEyeInner: return .rightEyeInner
        case .rightEye: return .rightEye
        case .rightEyeOuter: return .rightEyeOuter
        case .leftEar: return .leftEar
        case .rightEar: return .rightEar
        case .mouthLeft: return .mouthLeft
        case .mouthRight: return .mouthRight
        case .leftShoulder: return .leftShoulder
        case .rightShoulder: return .rightShoulder
        case .leftElbow: return .leftElbow
        case .rightElbow: return .rightElbow
        case .leftWrist: return .leftWrist
        case .rightWrist: return .rightWrist
        case .leftPinkyFinger: return .leftPinkyFinger
        case .rightPinkyFinger: return .rightPinkyFinger
        case .leftIndexFinger: return .leftIndexFinger
        case .rightIndexFinger: return .rightIndexFinger
        case .leftThumb: return .leftThumb
        case .rightThumb: return .rightThumb
        case .leftHip: return .leftHip
        case .rightHip: return .rightHip
        case .leftKnee: return .leftKnee
        case .rightKnee: return .rightKnee
        case .leftAnkle: return .leftAnkle
        case .rightAnkle: return .rightAnkle
        case .leftHeel: return .leftHeel
        case .rightHeel: return .rightHeel
        case .leftToe: return .leftToe
        case .rightToe: return .rightToe
        }
    }

    /// Create a landmark type from a pose landmark type.
    /// - Parameters:
    ///   - poseLandmark: the pose landmark type.
    // swiftlint:disable:next cyclomatic_complexity
    fileprivate init(poseLandmark: PoseLandmarkType) {
        switch poseLandmark {
        case .nose: self = .nose
        case .leftEyeInner: self = .leftEyeInner
        case .leftEye: self = .leftEye
        case .leftEyeOuter: self = .leftEyeOuter
        case .rightEyeInner: self = .rightEyeInner
        case .rightEye: self = .rightEye
        case .rightEyeOuter: self = .rightEyeOuter
        case .leftEar: self = .leftEar
        case .rightEar: self = .rightEar
        case .mouthLeft: self = .mouthLeft
        case .mouthRight: self = .mouthRight
        case .leftShoulder: self = .leftShoulder
        case .rightShoulder: self = .rightShoulder
        case .leftElbow: self = .leftElbow
        case .rightElbow: self = .rightElbow
        case .leftWrist: self = .leftWrist
        case .rightWrist: self = .rightWrist
        case .leftPinkyFinger: self = .leftPinkyFinger
        case .rightPinkyFinger: self = .rightPinkyFinger
        case .leftIndexFinger: self = .leftIndexFinger
        case .rightIndexFinger: self = .rightIndexFinger
        case .leftThumb: self = .leftThumb
        case .rightThumb: self = .rightThumb
        case .leftHip: self = .leftHip
        case .rightHip: self = .rightHip
        case .leftKnee: self = .leftKnee
        case .rightKnee: self = .rightKnee
        case .leftAnkle: self = .leftAnkle
        case .rightAnkle: self = .rightAnkle
        case .leftHeel: self = .leftHeel
        case .rightHeel: self = .rightHeel
        case .leftToe: self = .leftToe
        case .rightToe: self = .rightToe
        default: fatalError("PoseLandmarkType must match with one of the predefined values.")
        }
    }
}
