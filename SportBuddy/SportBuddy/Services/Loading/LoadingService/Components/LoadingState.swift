//
//  LoadingState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 28..
//

enum LoadingState {
    /// Show a full screen (aka a blocking) loading indicator.
    case fullScreenLoading

    /// Show a non-full screen (aka a non-blocking) loading indicator.
    case nonBlockingLoading

    /// Do not show any loading indicator.
    case notLoading

    var loading: Bool {
        if case .notLoading = self {
            return false
        }
        return true
    }
}
