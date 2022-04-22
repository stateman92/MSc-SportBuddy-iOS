//
//  Key.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 08..
//

protocol Key {
    /// The name of the key.
    var keyName: String { get }
}

extension Key where Self == StringKey {
    static var token: Key {
        StringKey(keyName: "token")
    }

    static var onboarding: Key {
        StringKey(keyName: "onboarding")
    }
}
