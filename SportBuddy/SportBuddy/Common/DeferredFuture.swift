//
//  DeferredFuture.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

import Combine

// swiftlint:disable:next identifier_name
func DeferredFuture<Output, Failure>(
    _ promise: @escaping (@escaping (Result<Output, Failure>) -> Void) -> Void
) -> Deferred<Future<Output, Failure>> where Failure: Error {
    Deferred {
        Future(promise)
    }
}
