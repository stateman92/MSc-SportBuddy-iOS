//
//  AVCaptureDevice+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import AVFoundation

extension AVCaptureDevice {
    /// Get the best available back camera.
    class var bestBackCameraDevice: AVCaptureDevice? {
        .default(.builtInTripleCamera, for: .video, position: .back) ??
            .default(.builtInDualCamera, for: .video, position: .back) ??
            .default(.builtInDualWideCamera, for: .video, position: .back) ??
            .default(.builtInWideAngleCamera, for: .video, position: .back)
    }

    /// Configure the device.
    /// - Parameters:
    ///   - _: the handler in which the device is locked, so any configuration can happen.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func configure(_ handler: (_ device: AVCaptureDevice) -> Void) -> Bool {
        do {
            try lockForConfiguration()
            handler(self)
            unlockForConfiguration()
        } catch {
            return false
        }
        return true
    }
}

extension AVCaptureDevice {
    /// Set the given `FocusMode`, if it's supported.
    /// - Parameters:
    ///   - focusMode: the given `FocusMode`.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(focusMode: FocusMode) -> Bool {
        if isFocusModeSupported(focusMode) {
            self.focusMode = focusMode
            return true
        }
        return false
    }

    /// Set the given `TorchMode`, if it's supported.
    /// - Parameters:
    ///   - torchMode: the given `TorchMode`.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(torchMode: TorchMode) -> Bool {
        if isTorchModeSupported(torchMode) {
            self.torchMode = torchMode
            return true
        }
        return false
    }

    /// Set the given `ExposureMode`, if it's supported.
    /// - Parameters:
    ///   - exposureMode: the given `ExposureMode`.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(exposureMode: ExposureMode) -> Bool {
        if isExposureModeSupported(exposureMode) {
            self.exposureMode = exposureMode
            return true
        }
        return false
    }

    /// Set whether smooth autofocus should be enabled, if it's supported.
    /// - Parameters:
    ///   - isSmoothAutoFocusEnabled: whether smooth autofocus should be enabled.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(isSmoothAutoFocusEnabled: Bool) -> Bool {
        if isSmoothAutoFocusSupported {
            self.isSmoothAutoFocusEnabled = isSmoothAutoFocusEnabled
            return true
        }
        return false
    }

    /// Set the given `WhiteBalanceMode`, if it's supported.
    /// - Parameters:
    ///   - whiteBalanceMode: the given `WhiteBalanceMode`.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(whiteBalanceMode: WhiteBalanceMode) -> Bool {
        if isWhiteBalanceModeSupported(whiteBalanceMode) {
            self.whiteBalanceMode = whiteBalanceMode
            return true
        }
        return false
    }

    /// Set the given exposure point of interest, if it's supported.
    /// - Parameters:
    ///   - exposurePointOfInterest: the given exposure point of interest.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(exposurePointOfInterest: CGPoint) -> Bool {
        if isExposurePointOfInterestSupported {
            self.exposurePointOfInterest = exposurePointOfInterest
            return true
        }
        return false
    }

    /// Set the given focus point of interest, if it's supported.
    /// - Parameters:
    ///   - focusPointOfInterest: the given focus point of interest.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(focusPointOfInterest: CGPoint) -> Bool {
        if isFocusPointOfInterestSupported {
            self.focusPointOfInterest = focusPointOfInterest
            return true
        }
        return false
    }

    /// Set whether geometric distortion correction should be enabled, if it's supported.
    /// - Parameters:
    ///   - isGeometricDistortionCorrectionEnabled: whether geometric distortion correction should be enabled.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(isGeometricDistortionCorrectionEnabled: Bool) -> Bool {
        if isGeometricDistortionCorrectionSupported {
            self.isGeometricDistortionCorrectionEnabled = isGeometricDistortionCorrectionEnabled
            return true
        }
        return false
    }

    /// Set the given autofocus range restriction, if it's supported.
    /// - Parameters:
    ///   - autoFocusRangeRestriction: the given `AutoFocusRangeRestriction`.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(autoFocusRangeRestriction: AutoFocusRangeRestriction) -> Bool {
        if isAutoFocusRangeRestrictionSupported {
            self.autoFocusRangeRestriction = autoFocusRangeRestriction
            return true
        }
        return false
    }
}

extension AVCaptureDevice {
    /// Request permission for camera access.
    /// - Parameters:
    ///   - granted: the closure that runs if the permission is granted.
    ///   - denied: the closure that runs if the permission is denied.
    /// - Note:
    /// If the permission has been already given / denied, the corresponding closure will run immediately.
    class func requestPermission(granted: @escaping () -> Void, denied: @escaping () -> Void) {
        switch authorizationStatus(for: .video) {
        case .authorized: granted()
        case .notDetermined: requestAccess(for: .video) { _ in requestPermission(granted: granted, denied: denied) }
        default: denied()
        }
    }
}
