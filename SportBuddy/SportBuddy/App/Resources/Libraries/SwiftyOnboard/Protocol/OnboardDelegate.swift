//
//  OnboardDelegate.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

protocol OnboardDelegate: AnyObject {
    func onboard(_ onboard: Onboard, currentPage index: Int)
    func onboard(_ onboard: Onboard, leftEdge position: Double)
    func onboard(_ onboard: Onboard, tapped index: Int)

}

extension OnboardDelegate {
    func onboard(_ onboard: Onboard, currentPage index: Int) { }
    func onboard(_ onboard: Onboard, leftEdge position: Double) { }
    func onboard(_ onboard: Onboard, tapped index: Int) { }
}
