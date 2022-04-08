//
//  InputType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 06..
//

enum InputType {
    /// Movie input type.
    case movie(isMirroring: Bool)

    /// Image input type.
    case photo
}

extension InputType {
    /// A movie type with `isMirroring` `false`.
    static let movie: Self = .movie(isMirroring: false)
}
