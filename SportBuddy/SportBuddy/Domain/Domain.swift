//
//  Domain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

class Domain<Cache> {
    // MARK: Nested types

    private enum DomainError: Error {
        case unknown
    }

    // MARK: Properties

    @LazyInjected private var loggingService: LoggingServiceProtocol
    @LazyInjected var loadingService: LoadingServiceProtocol
    @LazyInjected var cache: Cache
    var cancellables = Cancellables()
}

extension Domain {
    func log(_ message: String?, file: String = #file, function: String = #function, line: Int = #line) {
        let message = "APISuccess: \(message ?? "unknown")\(log(file: file, function: function, line: line))"
        loggingService.debug(message: message)
    }

    func log(_ error: Error?, file: String = #file, function: String = #function, line: Int = #line) {
        let message = "APIError: \(error ?? DomainError.unknown)\(log(file: file, function: function, line: line))"
        loggingService.debug(message: message)
    }

    func log(_ any: Any, file: String = #file, function: String = #function, line: Int = #line) {
        let message = "APISuccess: \(any)\(log(file: file, function: function, line: line))"
        loggingService.debug(message: message)
    }
}

extension Domain {
    private func log(file: String, function: String, line: Int) -> String {
        " in \(file), in \(function) at \(line)"
    }
}
