//
//  ExerciseScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import UIKit

final class ExerciseScreen:
    BaseScreen<ExerciseViewModelState, ExerciseViewModelCommand, ExerciseDomainImpl, ExerciseViewModel> {
    // MAKR: Properties

    private let videoPlayerView = VideoPlayerView()
    private let cameraSkeletonView = CameraSkeletonView()
    @LazyInjected private var cameraService: CameraService

    override func receiveState(_ state: ExerciseViewModelState) {
        super.receiveState(state)
        videoPlayerView.load(id: state.exercise.videoId)
    }
}

// MARK: - Lifecycle

extension ExerciseScreen {
    override func setupView() {
        super.setupView()
        setupVideoPlayerView()
        setupCameraSkeletonView()
    }
}

// MARK: - Setups

extension ExerciseScreen {
    private func setupVideoPlayerView() {
        videoPlayerView.then {
            view.addSubview($0)
            $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
            $0.anchorToSuperview(top: .zero, leading: 16, trailing: -16, safeArea: true)
        }
    }

    private func setupCameraSkeletonView() {
        cameraSkeletonView.then {
            view.addSubview($0)
            $0.anchorToSuperview(bottom: -16, leading: 16, trailing: -16, safeArea: true)
            $0.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 16).isActive = true
            cameraService.set(cameraView: $0)
        }
    }
}
