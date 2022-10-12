//
//  BoneEndpoint.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 06..
//

import CoreGraphics

struct BoneEndpoint {
    /// The type of the endpoint.
    let type: MLPoseLandmarkType

    /// The coordinate of the endpoint.
    let coordinate: CGPoint

    /// The path component of the endpoint.
    let pathComponent: PathComponent

    /// Create a `BoneEndpoint`.
    /// - Parameters:
    ///   - type: the type of the endpoint.
    ///   - coordinates: the coordinate of the endpoint.
    ///   - pathComponent: the path component of the endpoint. By default `.init()`.
    init(type: MLPoseLandmarkType, coordinate: CGPoint, pathComponent: PathComponent = .init()) {
        self.type = type
        self.coordinate = coordinate
        self.pathComponent = pathComponent
    }
}

// MARK: - Equatable

extension BoneEndpoint: Equatable {
    static func == (lhs: BoneEndpoint, rhs: BoneEndpoint) -> Bool {
        lhs.type == rhs.type
    }
}

// MARK: - Hashable

extension BoneEndpoint: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(type.rawValue)
    }
}

// MARK: - Public methods

extension BoneEndpoint {
    static func difference(lhs: BoneEndpoint?, rhs: BoneEndpoint?) -> BoneEndpoint? {
        guard let lhs, let rhs, lhs.type == rhs.type else { return nil }
        return BoneEndpoint(type: lhs.type, coordinate: lhs.coordinate - rhs.coordinate)
    }

    static func / (lhs: BoneEndpoint, rhs: CGFloat) -> BoneEndpoint {
        BoneEndpoint(type: lhs.type, coordinate: lhs.coordinate / rhs)
    }
}
