//
//  UITableView+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

extension UITableView {
    /// A more convinient method to dequeue a cell.
    /// - Parameter indexPath: tthe `IndexPath` of the cell.
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    /// Register a cell with a generic solution.
    /// - Parameter _: the type of the cell.
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
}

extension UITableView {
    func hasRow(at indexPath: IndexPath) -> Bool {
        indexPath.section >= .zero &&
        indexPath.row >= .zero &&
        indexPath.section < numberOfSections &&
        indexPath.row < numberOfRows(inSection: indexPath.section)
    }
}
