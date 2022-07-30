//
//  OnboardingDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol OnboardingDomain: Domain {
    var store: OnboardingStore { get }
    var action: OnboardingAction { get }
}
