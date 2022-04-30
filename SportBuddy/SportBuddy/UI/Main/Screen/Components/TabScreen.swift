//
//  TabScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

class TabScreen<ViewModelStore, ViewModelAction, ViewModel: BaseViewModel<ViewModelStore, ViewModelAction>>:
    BaseScreen<ViewModelStore, ViewModelAction, ViewModel> {
    // MARK: Initialization

    init(title: String) {
        super.init()
        self.title = title
    }

    // MARK: - Lifecycle

    override func setupView() {
        super.setupView()
        backgroundViewOptions.animating = false
    }
}
