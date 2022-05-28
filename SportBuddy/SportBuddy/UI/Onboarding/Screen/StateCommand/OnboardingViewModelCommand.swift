//
//  OnboardingViewModelCommand.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

import Foundation

enum OnboardingViewModelCommand {
    case navigateNext
}

class BaseCommand: Identifiable, Equatable {
    static func == (lhs: BaseCommand, rhs: BaseCommand) -> Bool {
        lhs.id == rhs.id
    }

    private static var _didInit = UUID()
    private static var _viewDidLoad = UUID()
    private static var _viewWillAppear = UUID()
    private static var _viewDidAppear = UUID()
    private static var _viewWillDisappear = UUID()
    private static var _viewDidDisappear = UUID()
    private static var _willDeinit = UUID()

    let id: UUID

    required init(value: UUID) {
        self.id = value
    }

    static var didInit: Self {
        .init(value: _didInit)
    }
}

final class OnboardingCommand: BaseCommand {
    private static var _navigateNext = UUID()

    static var navigateNext: Self {
        .init(value: _navigateNext)
    }
}

extension BaseCommand {
    struct Source {
        private let wrapped: BaseCommand
        fileprivate init(wrapping wrapped: BaseCommand) {
            self.wrapped = wrapped
        }
        public static func ~= (command: BaseCommand, source: BaseCommand.Source) -> Bool {
            source.wrapped.id == command.id
        }
    }

    var matching: Source {
        Source(wrapping: self)
    }

    func abc() {
        let command: OnboardingCommand = .navigateNext
        switch command {
        case .navigateNext: break
        case .didInit: break
        default: break
        }
    }
}
