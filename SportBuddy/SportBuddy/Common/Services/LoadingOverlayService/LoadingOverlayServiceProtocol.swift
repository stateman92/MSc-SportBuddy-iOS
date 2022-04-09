//
//  LoadingOverlayServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

import Foundation

/// A protocol for showing the loading states.
protocol LoadingOverlayServiceProtocol: AutoMockable {
    init(isShowing: Bool)
    func set(isShowing: Bool)
}

extension LoadingOverlayServiceProtocol {
    init() {
        self.init(isShowing: false)
    }
}
