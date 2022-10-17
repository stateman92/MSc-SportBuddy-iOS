//
//  CameraView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 26..
//

import AVFoundation
import UIKit

class CameraView: View {
    // MARK: Properties

    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        (layer as? AVCaptureVideoPreviewLayer)!
    }
}

// MARK: - Overridden methods

extension CameraView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
}
