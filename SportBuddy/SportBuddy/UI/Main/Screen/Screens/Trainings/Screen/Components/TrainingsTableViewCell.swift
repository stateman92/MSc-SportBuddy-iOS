//
//  TrainingsTableViewCell.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import UIKit

final class TrainingsTableViewCell: ReversedTableViewCell {
    // MARK: Properties

    @LazyInjected private var translatorService: TranslatorService

    // MARK: Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
}

// MARK: - Public methods

extension TrainingsTableViewCell {
    func setup(with data: ExerciseModel) {
        textLabel?.text = translatorService.translation(of: data.name)
        detailTextLabel?.text = data.details.map(translatorService.translation(of:))
    }
}
