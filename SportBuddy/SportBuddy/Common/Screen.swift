//
//  Screen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

class Screen<T: ViewModel>: UIViewController {
    @LazyInjected private(set) var viewModel: T

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background.color
    }
}
