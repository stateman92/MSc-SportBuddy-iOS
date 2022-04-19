//
//  ToastItem.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

struct ToastItem {
    let message: String
    let type: ToastType

    init(message: String, type: ToastType) {
        self.message = message
        self.type = type
    }
}
