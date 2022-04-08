//
//  MLPoseDetectorMode.swift
//  GoogleMLKitPoseDetection
//
//  Created by Kristof Kalai on 2022. 04. 06..
//

/// This mode switch can enhance performance.
enum MLPoseDetectorMode {
    /// Stream mode (video) of the detector.
    case stream

    /// Image mode (photo) of the detector.
    case singleImage
}
