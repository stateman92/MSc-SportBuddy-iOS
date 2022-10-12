//
//  Motion.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import Foundation

typealias RecordedData = TrajectoryElement<Date, Skeleton>

final class Motion {
    // MARK: Properties

    private(set) var trajectory = Trajectory<Date, Skeleton>()
}

extension Motion {
    func add(value: Skeleton) {
        trajectory.add(element: RecordedData(x: Date(), y: value))
    }

    // swiftlint:disable:next cyclomatic_complexity
    func firstDerivative(at date: Date) -> RecordedData? {
        guard let firstData = trajectory.values.first,
              let lastData = trajectory.values.last else { return nil }
        if date < firstData.x || date > lastData.x {
            return nil
        }
        if let index = trajectory.values.firstIndex(where: { $0.x == date }) {
            if index == 0 {
                return derivative(firstData: firstData,
                                  secondData: trajectory.values[safe: index + 1])
            } else if index == trajectory.values.count - 1 {
                return derivative(firstData: trajectory.values[safe: index - 2],
                                  secondData: lastData)
            } else {
                return derivative(firstData: trajectory.values[safe: index - 1],
                                  secondData: trajectory.values[safe: index + 1])
            }
        } else if let index = trajectory.values.firstIndex(where: { $0.x < date }) {
            if index == 0 {
                return derivative(firstData: firstData,
                                  secondData: trajectory.values[safe: index + 1])
            } else if index == trajectory.values.count - 2 {
                return derivative(firstData: trajectory.values[safe: index - 2],
                                  secondData: lastData)
            } else {
                return derivative(firstData: trajectory.values[safe: index],
                                  secondData: trajectory.values[safe: index + 1])
            }
        } else {
            return nil
        }
    }

    func derivatives(of recordedData: [RecordedData]? = nil) -> [RecordedData] {
        let line = (recordedData ?? trajectory.values)
        return line.enumerated()
            .map { derivative(firstData: $0.element, secondData: line[safe: $0.offset + 1]) }
            .compactMap { $0 }
    }

    func secondDerivatives() -> [RecordedData] {
        derivatives(of: derivatives())
    }
}

extension Motion {
    private func derivative(firstData: RecordedData?, secondData: RecordedData?) -> RecordedData? {
        guard let firstData, let secondData else { return nil }
        let previousData = firstData.x < secondData.x ? firstData : secondData
        let nextData = previousData.x == firstData.x ? secondData : firstData
        let difference = 1.cgFloat
        return RecordedData(x: previousData.x.addingTimeInterval(difference.double / 2),
                            y: Skeleton(face: (nextData.y.face - previousData.y.face) / difference,
                                        body: (nextData.y.body - previousData.y.body) / difference,
                                        arms: (nextData.y.arms - previousData.y.arms) / difference,
                                        legs: (nextData.y.legs - previousData.y.legs) / difference))
    }
}
