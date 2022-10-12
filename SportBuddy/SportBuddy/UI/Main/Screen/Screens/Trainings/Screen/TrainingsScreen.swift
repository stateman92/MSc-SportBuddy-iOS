//
//  TrainingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

final class TrainingsScreen:
    TabScreen<TrainingsViewModelState, TrainingsViewModelCommand, TrainingsDomainImpl, TrainingsViewModel> {
    @LazyInjected var cameraService: CameraService

    // MARK: Initialization

    init() {
        super.init(title: L10n.Trainings.title)
    }
}

// MARK: - Lifecycle

extension TrainingsScreen {
    override func setupView() {
        super.setupView()
        setupCameraView()
    }
}

// MARK: - Setups

extension TrainingsScreen {
    private func setupCameraView() {
        let skeletonView = SkeletonView()
        let cameraView = CameraView().then {
            view.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
            cameraService.set(cameraView: $0)
            cameraService.skeletonShouldUpdate { [weak self] boneEndpoints in
                dispatchToMain {
                    let skeleton = Skeleton(from: boneEndpoints)
                    skeletonView.skeleton = skeleton
                    self?.sendCommand(.interpret(skeleton))
                }
            }
        }
        skeletonView.then {
            cameraView.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}
