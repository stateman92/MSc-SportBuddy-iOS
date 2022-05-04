//
//  Typealiases.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import Combine
import Foundation

typealias DomainActionPublisher = AnyPublisher<Void, Error>
typealias DomainStorePublisher<T> = AnyPublisher<T, Never>
typealias DomainActionResult<T> = Result<T, Error>

typealias Color = Assets.Colors
typealias Images = Assets.Images
typealias Cancellables = Set<AnyCancellable>
