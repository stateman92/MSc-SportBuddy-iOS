//
//  OnboardOverlay.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

protocol OnboardOverlay: UIView {
    var pageControl: UIPageControl { get }
    var continueButton: UIButton { get }
    var skipButton: UIButton { get }

    func currentPage(index: Int)
    func page(count: Int)
}
