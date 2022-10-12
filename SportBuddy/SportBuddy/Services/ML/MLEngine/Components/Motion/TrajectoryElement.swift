//
//  TrajectoryElement.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

final class TrajectoryElement<X: Comparable, Y> {
    // MARK: Properties

    let x: X
    let y: Y

    // MARK: Initialization

    init(x: X, y: Y) {
        self.x = x
        self.y = y
    }
}
