//
//  CameraView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 26..
//

import AVFoundation
import UIKit

final class CameraView: View { }

extension CameraView {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        (layer as? AVCaptureVideoPreviewLayer)!
    }

    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
}
