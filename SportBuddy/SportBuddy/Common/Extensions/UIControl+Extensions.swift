//
//  UIControl+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, _ action: @escaping () -> Void) {
        addAction(.init(handler: { _ in
            action()
        }), for: controlEvents)
    }
}
