//
//  ToastHandlingServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit.UIWindow

protocol ToastHandlingServiceProtocol {
    init(window: UIWindow)
    func showToast(with item: ToastItem)
    func invalidateQueue()
}
