//
//  SwipingSegment.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 31..
//

import UIKit

protocol SwipingSegment {
    var intrinsicContentSize: CGSize? { get }
    var normalView: UIView { get }
    var selectedView: UIView { get }
}
