// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class MLEngineMock: MLEngine {

    //MARK: - set

    var setExerciseCallsCount = 0
    var setExerciseCalled: Bool {
        return setExerciseCallsCount > 0
    }
    var setExerciseReceivedExercise: ExerciseModel?
    var setExerciseReceivedInvocations: [ExerciseModel] = []
    var setExerciseClosure: ((ExerciseModel) -> Void)?

    func set(exercise: ExerciseModel) {
        setExerciseCallsCount += 1
        setExerciseReceivedExercise = exercise
        setExerciseReceivedInvocations.append(exercise)
        setExerciseClosure?(exercise)
    }

    //MARK: - interpret

    var interpretSkeletonCallsCount = 0
    var interpretSkeletonCalled: Bool {
        return interpretSkeletonCallsCount > 0
    }
    var interpretSkeletonReceivedSkeleton: Skeleton?
    var interpretSkeletonReceivedInvocations: [Skeleton] = []
    var interpretSkeletonClosure: ((Skeleton) -> Void)?

    func interpret(skeleton: Skeleton) {
        interpretSkeletonCallsCount += 1
        interpretSkeletonReceivedSkeleton = skeleton
        interpretSkeletonReceivedInvocations.append(skeleton)
        interpretSkeletonClosure?(skeleton)
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
