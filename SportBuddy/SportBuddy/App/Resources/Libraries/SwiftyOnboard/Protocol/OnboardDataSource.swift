//
//  OnboardDataSource.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

protocol OnboardDataSource: AnyObject {
    func onboardBackgroundColorFor(_ onboard: Onboard, atIndex index: Int) -> UIColor?
    func onboardNumberOfPages(_ onboard: Onboard) -> Int
    func onboardViewForBackground(_ onboard: Onboard) -> UIView?
    func onboardPageForIndex(_ onboard: Onboard, index: Int) -> OnboardPage?
    func onboardViewForOverlay(_ onboard: Onboard) -> OnboardOverlay?
    func onboardOverlayForPosition(_ onboard: Onboard, overlay: OnboardOverlay, for position: Double)
}

extension OnboardDataSource {
    func onboardBackgroundColorFor(_ onboard: Onboard,atIndex index: Int) -> UIColor? {
        nil
    }

    func onboardViewForBackground(_ onboard: Onboard) -> UIView? {
        nil
    }

    func onboardOverlayForPosition(_ onboard: Onboard, overlay: OnboardOverlay, for position: Double) { }

    func onboardViewForOverlay(_ onboard: Onboard) -> OnboardOverlay? {
        DefaultOnboardOverlay()
    }
}
