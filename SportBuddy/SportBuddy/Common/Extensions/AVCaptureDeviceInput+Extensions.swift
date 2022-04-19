//
//  AVCaptureDeviceInput+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import AVFoundation

extension AVCaptureDeviceInput {
    /// Make an `AVCaptureDeviceInput` based on a device.
    /// - Parameters:
    ///   - device: the device.
    /// - Note:
    /// It deals with `Optional`s too.
    convenience init?(device: AVCaptureDevice?) {
        guard let device = device else { return nil }
        try? self.init(device: device)
    }

    /// Get the size of the input.
    var size: CGSize {
        let dimensions = CMVideoFormatDescriptionGetDimensions(device.activeFormat.formatDescription)
        return CGSize(width: Int(dimensions.height), height: Int(dimensions.width))
    }
}
