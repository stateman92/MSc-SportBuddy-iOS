//
//  CameraSkeletonView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 15..
//

final class CameraSkeletonView: CameraView {
    // MARK: Properties

    private let skeletonView = SkeletonView()
    var skeleton: Skeleton? {
        didSet {
            skeletonView.skeleton = skeleton
        }
    }
    var showSkeleton = true {
        didSet {
            skeletonView.isHidden = !showSkeleton
        }
    }

    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension CameraSkeletonView {
    private func setupView() {
        setupSkeletonView()
    }

    private func setupSkeletonView() {
        skeletonView.then {
            addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}
