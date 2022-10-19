//
//  AnyPublisher+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import Combine

extension AnyPublisher {
    static func just<Output>(_ output: Output) -> AnyPublisher<Output, Never> {
        Just(output).eraseToAnyPublisher()
    }
}
