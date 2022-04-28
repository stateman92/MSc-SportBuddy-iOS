//
//  NavigationType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 21..
//

enum NavigationType {
    case present(animated: Bool)
    case push(animated: Bool)
    case crossDissolve

    static var present: Self {
        .present(animated: true)
    }

    static var push: Self {
        .push(animated: true)
    }
}
