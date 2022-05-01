//
//  DomainActionPublisher.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import Combine
import Foundation

typealias DomainActionPublisher = AnyPublisher<Void, Error>
typealias DomainStorePublisher<T> = AnyPublisher<T, Never>
typealias DomainActionResult<T> = Result<T, Error>
