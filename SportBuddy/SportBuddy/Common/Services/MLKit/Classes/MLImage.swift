//
//  MLImage.swift
//  GoogleMLKitPoseDetection
//
//  Created by Kristof Kalai on 2022. 04. 06..
//

import CoreMedia
import UIKit

enum MLImage {
    /// `UIImage` backed `MLImage`.
    case image(UIImage)

    /// `CMSampleBuffer` backed `MLImage`.
    case buffer(CMSampleBuffer)
}
