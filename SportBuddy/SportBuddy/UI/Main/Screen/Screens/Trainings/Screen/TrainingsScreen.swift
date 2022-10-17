//
//  TrainingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

final class TrainingsScreen:
    TabScreen<TrainingsViewModelState, TrainingsViewModelCommand, TrainingsDomainImpl, TrainingsViewModel> {
    // MARK: Properties

    @LazyInjected private var cameraService: CameraService
    private let cameraView = CameraSkeletonView()

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
        cameraView.then {
            view.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
            cameraService.set(cameraView: $0)

//            cameraService.skeletonShouldUpdate { [weak self] boneEndpoints in
//                dispatchToMain {
//                    let skeleton = Skeleton(from: boneEndpoints)
//                    cameraView.skeleton = skeleton
//                    self?.sendCommand(.interpret(skeleton))
//                }
//            }

//            Task { [unowned self] in
//                for await endpoints in cameraService.skeletonShouldUpdate() {
//                    let skeleton = Skeleton(from: endpoints)
//                    cameraView.skeleton = skeleton
//                    sendCommand(.interpret(skeleton))
//                }
//            }

            cameraService.skeletonShouldUpdate()
                .map(Skeleton.init(from:))
                .sink { [unowned self] in
                    cameraView.skeleton = $0
                    sendCommand(.interpret($0))
                }
                .store(in: &cancellables)
        }
    }
}
