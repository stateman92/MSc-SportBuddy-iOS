//
//  Trajectory.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

final class Trajectory<X: Comparable, Y> {
    // MARK: Properties

    private var elements = [TrajectoryElement<X, Y>]()
    var values: [TrajectoryElement<X, Y>] {
        elements
    }
}

// MARK: - Public methods

extension Trajectory {
    func add(element: TrajectoryElement<X, Y>) {
        elements.append(element)
    }
}
