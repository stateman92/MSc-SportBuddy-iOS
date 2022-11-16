//
//  ExerciseViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

struct ExerciseViewModelState {
    let exercise: ExerciseModel
}

extension ExerciseViewModelState: Initable {
    init() {
        self.init(exercise: .init(id: .init(),
                                  sequence: .init(),
                                  sequenceCount: .zero,
                                  delay: .zero,
                                  videoId: .init(),
                                  name: .init(),
                                  details: .init()))
    }
}

extension ExerciseViewModelState: Equatable { }

extension ExerciseViewModelState: CustomStringConvertible {
    var description: String {
        "..." // skip printing for concise logging
    }
}
