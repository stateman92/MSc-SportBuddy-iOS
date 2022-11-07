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

    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension CameraView {
    private func setupView() {
        setupSimulatorWarning()
    }

    private func setupSimulatorWarning() {
        runOnDevice(real: { }, simulator: {
            let view = View().then {
                addSubview($0)
                $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero, safeArea: true)
                $0.backgroundColor = .black
            }
            Label().then {
                view.addSubview($0)
                $0.anchorToCenter()
                $0.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor).isActive = true
                $0.text = "CameraView is not available on simulator, use a real device!".uppercased()
                $0.numberOfLines = .zero
                $0.textAlignment = .center
                $0.textColor = .white
            }
        })
    }
}

// MARK: - Overridden methods

extension CameraView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
}
