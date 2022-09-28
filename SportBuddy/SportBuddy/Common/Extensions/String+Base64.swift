//
//  String+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 26..
//

import Foundation

extension String {
    var isBase64: Bool {
        !trimmingCharacters(in: .whitespaces).isEmpty && Data(base64Encoded: self) != nil
    }
}
