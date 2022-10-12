//
//  SkeletonView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 13..
//

import UIKit

final class SkeletonView: View {
    // MARK: Properties

    var skeleton: Skeleton? {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension SkeletonView {
    private func setupView() {
        backgroundColor = .clear
    }
}

// MARK: - Overridden methods

extension SkeletonView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        skeleton?.bones.forEach { drawBone(bone: $0) }
    }
}

// MARK: - Private methods

extension SkeletonView {
    private func drawBone(bone: Bone) {
        guard let line = bone.line else { return }
        drawLine(line: line, pathComponent: bone.pathComponent)
        [bone.starting, bone.ending].compactMap { $0 }.forEach { drawBoneEndpoint(boneEndpoint: $0) }
    }

    private func drawBoneEndpoint(boneEndpoint: BoneEndpoint) {
        drawCircle(point: boneEndpoint.coordinate, pathComponent: boneEndpoint.pathComponent)
    }

    private func drawCircle(point: CGPoint, radius: CGFloat = 5, pathComponent: PathComponent) {
        UIBezierPath.circle(center: point, radius: radius).drawWith(pathComponent: pathComponent)
    }
    private func drawLine(line: CGLine, pathComponent: PathComponent) {
        UIBezierPath.line(line).drawWith(pathComponent: pathComponent)
    }
}
