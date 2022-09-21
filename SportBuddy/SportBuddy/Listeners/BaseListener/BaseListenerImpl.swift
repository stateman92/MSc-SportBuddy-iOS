//
//  BaseListenerImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import Combine
import Foundation

class BaseListenerImpl {
    // MARK: Properties

    var cancellables = Cancellables()
}

// MARK: - BaseListener

extension BaseListenerImpl: BaseListener {
    @objc func start() { }
}
