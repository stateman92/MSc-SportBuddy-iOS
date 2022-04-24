//
//  RequestBuilder+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 21..
//

extension RequestBuilder {
    @discardableResult func addToken() -> Self {
        guard let token: String = SettingsHelper.retrieve(forKey: .token) else {
            return self
        }
        return addHeader(name: "Authorization", value: "Bearer " + token)
    }
}
