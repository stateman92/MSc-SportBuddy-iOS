//
//  RequestBuilder+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 21..
//

import Foundation

extension RequestBuilder {
    @discardableResult func addToken() -> Self {
        guard let tokenObject: TokenCache.Object = SettingsHelper.retrieve(forKey: .token) else {
            return self
        }
        return addHeader(name: Constants.NetworkRequest.Authorization.key,
                         value: Constants.NetworkRequest.Authorization.value(token: tokenObject.token.uuidString))
    }
}
