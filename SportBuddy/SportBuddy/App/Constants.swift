//
//  Constants.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 24..
//

enum Constants {
    enum Files {
        static let configuration = "Configuration"
        static let launchScreen = "LaunchScreen"
    }

    enum Extensions: String {
        case lproj
        case plist
    }

    enum NetworkRequest {
        enum Authorization {
            static let key = "Authorization"
            static func value(token: String) -> String {
                "Bearer " + token
            }
        }
    }
}
