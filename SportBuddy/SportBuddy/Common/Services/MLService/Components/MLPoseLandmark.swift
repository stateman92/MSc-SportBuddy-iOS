//
//  MLPoseLandmark.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 06..
//

import CoreGraphics

struct MLPoseLandmark {
    /// The type of the landmark.
    let type: MLPoseLandmarkType

    /// The position of the landmark.
    let position: CGPoint

    /// Create a landmark.
    /// - Parameters:
    ///   - type: the type of the landmark.
    ///   - position: the position of the landmark.
    init(type: MLPoseLandmarkType, position: CGPoint) {
        self.type = type
        self.position = position
    }
}

extension MLPoseLandmark {
    /// Get the screen coordinates of a landmark.
    /// - Parameters:
    ///   - for: the input type.
    ///   - size: the size.
    ///   - destinationRect: the rectangle of the destination.
    /// - Returns:
    ///     The screen coordinates.
    func getScreenCoordinates(for inputType: InputType, size: CGSize, destinationRect: CGRect) -> CGPoint {
        switch inputType {
        case let .movie(isMirroring):
            if isMirroring {
                return CGPoint(
                    x: position.y / size.width * destinationRect.width + destinationRect.origin.x,
                    y: (size.height - position.x) / size.height * destinationRect.height + destinationRect.origin.y - 5)
            } else {
                return CGPoint(
                    x: (size.width - position.y) / size.width * destinationRect.width + destinationRect.origin.x,
                    y: (position.x) / size.height * destinationRect.height + destinationRect.origin.y - 5)
            }
        case .photo: return CGPoint(x: position.x / size.width * destinationRect.width + destinationRect.origin.x,
                                    y: position.y / size.height * destinationRect.height + destinationRect.origin.y - 5)
        }
    }
}
