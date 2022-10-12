//
//  Bone.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

struct Bone {
    // MARK: Properties

    let starting: BoneEndpoint?
    let ending: BoneEndpoint?
    let pathComponent: PathComponent

    var line: CGLine? {
        guard let startingPoint = starting?.coordinate, let endingPoint = ending?.coordinate else { return nil }
        return CGLine(startingPoint: startingPoint, endingPoint: endingPoint)
    }

    // MARK: Initialization

    init(starting: BoneEndpoint?, ending: BoneEndpoint?, pathComponent: PathComponent = PathComponent()) {
        self.starting = starting
        self.ending = ending
        self.pathComponent = pathComponent
    }
}
