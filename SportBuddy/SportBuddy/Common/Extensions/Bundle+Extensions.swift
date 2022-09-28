//
//  Bundle+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 25..
//

import Foundation

extension Bundle {
    func data(forResource resource: String?, withExtension extension: String?) -> Data? {
        guard let url = url(forResource: resource, withExtension: `extension`) else { return nil }
        return try? Data(contentsOf: url)
    }
}
