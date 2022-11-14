//
//  TrainingsTableViewCell.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import UIKit

final class TrainingsTableViewCell: BaseTwoRowTableViewCell {
    // MARK: Properties

    @LazyInjected private var translatorService: TranslatorService
}

// MARK: - Public methods

extension TrainingsTableViewCell {
    func setup(with data: ExerciseModel) {
        setup(with: translatorService.translation(of: data.name),
              details: data.details.map(translatorService.translation(of:)))
    }
}
