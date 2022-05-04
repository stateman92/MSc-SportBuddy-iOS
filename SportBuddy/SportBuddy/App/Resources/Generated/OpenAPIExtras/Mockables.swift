//
//  Mockables.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Foundation

protocol Mockable {
    static var mock: Self { get }
}

extension SportTypeDTO: Mockable {
    static var mock: Self {
        .workout
    }
}

extension Int: Mockable {
    static var mock: Self {
        5
    }
}

extension Bool: Mockable {
    static var mock: Self {
        true
    }
}

extension String: Mockable {
    static var mock: Self {
        "mockString"
    }
}

extension Array where Element: Mockable {
    static var mock: Self {
        [.mock, .mock]
    }
}

extension UUID: Mockable {
    static var mock: Self {
        .init()
    }
}

extension ExerciseFractionTimeUnitDTO: Mockable {
    static var mock: Self {
        .init(fromTime: .mock, toTime: .mock)
    }
}

extension ExerciseTypeDTO: Mockable {
    static var mock: Self {
        .running
    }
}

extension UserResponseDTO: Mockable {
    static var mock: Self {
        .init(token: .mock, user: .mock)
    }
}

extension UserDTO: Mockable {
    static var mock: Self {
        .init(primaryId: .mock, name: .mock, email: .mock, profileImage: .mock, bio: .mock, chats: .mock, groups: .mock)
    }
}

extension MotionTypeDTO: Mockable {
    static var mock: Self {
        .runningmotion1
    }
}

extension ChatDTO: Mockable {
    static var mock: Self {
        .init(primaryId: .mock, users: .mock, chatEntries: .mock, image: .mock)
    }
}

extension ChatEntryDTO: Mockable {
    static var mock: Self {
        .init(primaryId: .mock, message: .mock, timestamp: .mock, sender: .mock, deleted: .mock)
    }
}

extension GroupDTO: Mockable {
    static var mock: Self {
        .init(primaryId: .mock, sportType: .mock, users: .mock, groupEntries: .mock, image: .mock)
    }
}

extension GroupEntryDTO: Mockable {
    static var mock: Self {
        .init(primaryId: .mock, message: .mock, timestamp: .mock, sender: .mock, deleted: .mock)
    }
}

extension ExerciseDTO: Mockable {
    static var mock: Self {
        .init(primaryId: .mock, exerciseType: .mock, previewImage: .mock, exerciseVideoUrl: .mock, fractions: .mock)
    }
}

extension ExerciseFractionDTO: Mockable {
    static var mock: Self {
        .init(time: .mock, motionType: .mock)
    }
}
