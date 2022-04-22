//
//  UserCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

final class UserCache: Cache<UserDTO> {
    override func save(item: UserDTO) {
        super.save(item: item)
        dump("UserDTO: \(item).")
    }
}
