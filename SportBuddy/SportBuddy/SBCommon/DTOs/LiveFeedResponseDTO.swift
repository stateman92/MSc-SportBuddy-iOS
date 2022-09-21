//
//  LiveFeedResponseDTO.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 17..
//

import Foundation

struct LiveFeedResponseDTO: Codable, Equatable {
    // MARK: Properties

    let image: String? // if nil, it means that it is our message
    let message: String
    let date: Date
}
