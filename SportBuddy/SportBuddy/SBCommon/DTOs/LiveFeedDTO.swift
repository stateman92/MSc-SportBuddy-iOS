//
//  LiveFeedDTO.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 17..
//

import Foundation

struct LiveFeedDTO: Codable, Equatable {
    // MARK: Properties

    let sender: UUID
    let message: String
    let date: Date
}
