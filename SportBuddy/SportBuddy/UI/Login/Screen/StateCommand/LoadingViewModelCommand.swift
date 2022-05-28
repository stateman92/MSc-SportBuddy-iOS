//
//  LoadingViewModelCommand.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

enum LoadingViewModelCommand {
    case login(email: String, password: String)
    case signUp(name: String, email: String, password: String)
    case forgotPassword(email: String)
    case googleLogin(token: String)
}
