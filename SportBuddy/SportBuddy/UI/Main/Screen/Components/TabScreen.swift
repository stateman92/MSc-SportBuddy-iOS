//
//  TabScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

class TabScreen<ViewModel: BaseViewModel>: BaseScreen<ViewModel> {
    // MARK: Initialization

    override init() {
        super.init()
        backgroundViewOptions.animating = false
    }
}
