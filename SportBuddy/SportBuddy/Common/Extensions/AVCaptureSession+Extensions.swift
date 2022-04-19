//
//  AVCaptureSession+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import AVFoundation

extension AVCaptureSession {
    /// Try to add an input.
    /// - Parameters:
    ///   - input: the `AVCaptureInput`.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToAdd(input: AVCaptureInput) -> Bool {
        if canAddInput(input) {
            addInput(input)
            return true
        }
        return false
    }

    /// Try to add an output.
    /// - Parameters:
    ///   - output: the `AVCaptureOutput`.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToAdd(output: AVCaptureOutput) -> Bool {
        if canAddOutput(output) {
            addOutput(output)
            return true
        }
        return false
    }

    /// Try to set a preset.
    /// - Parameters:
    ///   - preset: the `Preset`.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func tryToSet(preset: Preset) -> Bool {
        if canSetSessionPreset(preset) {
            sessionPreset = preset
            return true
        }
        return false
    }

    /// Stop the session if running.
    func stopIfRunning() {
        if isRunning {
            stopRunning()
        }
    }

    /// Configure the session.
    /// - Parameters:
    ///   - _: the handler in which the session is locked, so any configuration can happen.
    /// - Returns:
    ///     The returned value of the handler function.
    func configure<T>(_ handler: (_ session: AVCaptureSession) -> T) -> T {
        beginConfiguration()
        let value = handler(self)
        commitConfiguration()
        return value
    }

    /// Remove all connections, inputs and outputs from the session.
    func reset() {
        connections.forEach { removeConnection($0) }
        inputs.forEach { removeInput($0) }
        outputs.forEach { removeOutput($0) }
    }
}
