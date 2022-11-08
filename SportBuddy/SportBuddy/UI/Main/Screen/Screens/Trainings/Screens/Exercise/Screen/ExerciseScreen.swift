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
    private let changeCameraButton = ButtonLabel(text: "Change camera", size: .small)
    private var isSmall = true
    private lazy var smallConstraints = {
        [
            cameraSkeletonView.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 16),
            cameraSkeletonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            cameraSkeletonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cameraSkeletonView.widthAnchor.constraint(equalTo: cameraSkeletonView.heightAnchor, multiplier: 9 / 16)
        ]
    }()
    private lazy var bigConstraint = {
        [
            cameraSkeletonView.topAnchor.constraint(equalTo: view.topAnchor),
            cameraSkeletonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cameraSkeletonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraSkeletonView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
    }()
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
        setupChangeCameraButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraService.videoSize = cameraSkeletonView.bounds.size
    }
}

// MARK: - Setups

extension ExerciseScreen {
    private func setupVideoPlayerView() {
        videoPlayerView.then {
            view.addSubview($0)
            $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
            $0.anchorToSuperview(top: .zero, leading: 16, trailing: -16, safeArea: true)
        }
    }

    private func setupCameraSkeletonView() {
        cameraSkeletonView.then {
            view.addSubview($0)
//            NSLayoutConstraint.activate(bigConstraint)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
            cameraService.set(cameraView: $0)
            cameraService.changeCamera()
            cameraService.skeletonShouldUpdate { [weak self] in
                let skeleton = Skeleton(from: $0)
                dispatchToMain {
                    self?.sendCommand(.detect(skeleton: skeleton))
                    if self?.isSmall == false {
                        self?.cameraSkeletonView.skeleton = skeleton
                    }
                }
            }
            $0.addTapGestureRecognizer { [weak self] in
                guard let self else { return }
                if self.isSmall {
                    NSLayoutConstraint.deactivate(self.smallConstraints)
                    NSLayoutConstraint.activate(self.bigConstraint)
                } else {
                    NSLayoutConstraint.deactivate(self.bigConstraint)
                    NSLayoutConstraint.activate(self.smallConstraints)
                }
                self.isSmall.toggle()
                self.cameraSkeletonView.skeleton = nil
                UIView.animate(withDuration: 0.5, options: [.allowUserInteraction, .beginFromCurrentState]) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    private func setupChangeCameraButton() {
        changeCameraButton.then {
            view.addSubview($0)
            $0.leadingAnchor.constraint(equalTo: cameraSkeletonView.trailingAnchor, constant: 16).isActive = true
            $0.bottomAnchor.constraint(equalTo: cameraSkeletonView.bottomAnchor).isActive = true
            $0.tapped { [weak self] in
                self?.cameraService.changeCamera()
            }
        }
    }
}
