//
//  ExerciseDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

final class ExerciseDomainImpl {
    // MARK: Properties

    @LazyInjected var store: ExerciseStore
    @LazyInjected var action: ExerciseAction
}

// MARK: - ExerciseDomain

extension ExerciseDomainImpl: ExerciseDomain { }
