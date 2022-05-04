//
//  ErrorResponse+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

extension ErrorResponse {
    var isUnauthenticated: Bool {
        switch self {
        case let .error(errorCode, _, _, _): return errorCode == 401
        }
    }
}
