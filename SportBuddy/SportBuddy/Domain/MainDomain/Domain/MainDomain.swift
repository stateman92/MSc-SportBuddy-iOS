//
//  MainDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol MainDomain: Domain {
    var store: MainStore { get }
    var action: MainAction { get }
}
