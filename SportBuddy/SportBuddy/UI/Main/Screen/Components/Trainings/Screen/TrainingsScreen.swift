//
//  TrainingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

final class TrainingsScreen: TabScreen<TrainingsViewModel> {
    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension TrainingsScreen {
    private func setupView() {
        title = "Trainings"
        setupCameraView()
    }

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
