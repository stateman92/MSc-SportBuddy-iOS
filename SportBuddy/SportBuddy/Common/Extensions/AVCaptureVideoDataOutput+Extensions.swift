//
//  AVCaptureVideoDataOutput+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import AVFoundation
import Foundation

extension AVCaptureVideoDataOutput {
    /// Make a `AVCaptureVideoDataOutput`.
    /// - Parameters:
    ///   - alwaysDiscardsLateVideoFrames: whether to discard late video frames.
    convenience init(alwaysDiscardsLateVideoFrames: Bool) {
        self.init()
        self.alwaysDiscardsLateVideoFrames = alwaysDiscardsLateVideoFrames
    }
}

extension AVCaptureVideoDataOutput {
    private final class CaptureVideoDataOutputSampleBufferDelegate: NSObject,
                                                                    AVCaptureVideoDataOutputSampleBufferDelegate,
                                                                    AVCaptureAudioDataOutputSampleBufferDelegate {
        private let didOutput: (CMSampleBuffer) -> Void

        /// Create a `CaptureAVDataOutputSampleBufferDelegate`.
        /// - Parameters:
        ///   - didOutput: this function will be called if a frame (sample) is taken.
        init(didOutput: @escaping (CMSampleBuffer) -> Void) {
            self.didOutput = didOutput
        }

        func captureOutput(_ output: AVCaptureOutput,
                           didOutput sampleBuffer: CMSampleBuffer,
                           from connection: AVCaptureConnection) {
            didOutput(sampleBuffer)
        }
    }

    enum AssociatedObjectKeys {
        fileprivate static var captureAVDataOutputSampleBufferDelegate = "captureAVDataOutputSampleBufferDelegate"
    }

    /// The `CaptureVideoDataOutputSampleBufferDelegate`,
    private var captureAVDataOutputSampleBufferDelegate: CaptureVideoDataOutputSampleBufferDelegate? {
        get {
            getAssociatedObject(self, &AssociatedObjectKeys.captureAVDataOutputSampleBufferDelegate)
        }
        set {
            setAssociatedObject(self, &AssociatedObjectKeys.captureAVDataOutputSampleBufferDelegate, newValue)
        }
    }

    /// Call to get a callback for each taken frame / sample.
    /// - Parameters:
    ///   - on: on which queue should the closure be called. By default `.main`.
    ///   - completion: this function will be called if a farme / sample is taken.
    func setSampleBufferDelegate(on queue: DispatchQueue = .main, completion: @escaping (CMSampleBuffer) -> Void) {
        captureAVDataOutputSampleBufferDelegate = CaptureVideoDataOutputSampleBufferDelegate(didOutput: completion)
        setSampleBufferDelegate(captureAVDataOutputSampleBufferDelegate, queue: queue)
    }
}
