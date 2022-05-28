//
//  TrainingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

// swiftlint:disable:next colon
final class TrainingsScreen:
    TabScreen<TrainingsViewModelState, TrainingsViewModelCommand, TrainingsDomain, TrainingsViewModel> {
    @LazyInjected var cameraService: CameraServiceProtocol

    // MARK: Initialization

    init() {
        super.init(title: "Trainings")
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
        CameraView().then {
            view.addSubview($0)
            $0.anchorToCenter()
            $0.setSize(.init(width: 200, height: 300))
            cameraService.set(cameraView: $0)
            cameraService.skeletonShouldUpdate { boneEndpoints in
                dump(boneEndpoints)
            }
        }
    }
}
