//
//  OnboardingDomainProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol OnboardingDomainProtocol: DomainProtocol {
    var store: OnboardingStoreProtocol { get }
    var action: OnboardingActionProtocol { get }
}
