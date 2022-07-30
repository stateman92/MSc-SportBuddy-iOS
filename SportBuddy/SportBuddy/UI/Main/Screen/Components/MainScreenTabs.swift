//
//  MainScreenTabs.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class MainScreenTabs {
    // MARK: Properties

    @LazyInjected private var groupsScreen: GroupsScreen
    @LazyInjected private var chatsScreen: ChatsScreen
    @LazyInjected private var trainingsScreen: TrainingsScreen
    @LazyInjected private var settingsScreen: SettingsScreen
    @LazyInjected private var systemImageService: SystemImageService

    // MARK: Initialization

    init() {
        groupsScreen.tabBarItem.image = systemImageService.image(symbol: .person3)
        groupsScreen.tabBarItem.selectedImage = systemImageService.image(symbol: .person3Fill)

        chatsScreen.tabBarItem.image = systemImageService.image(symbol: .rectangle3GroupBubbleLeft)
        chatsScreen.tabBarItem.selectedImage = systemImageService.image(symbol: .rectangle3GroupBubbleLeftFill)

        trainingsScreen.tabBarItem.image = systemImageService.image(symbol: .figureWalkCircle)
        trainingsScreen.tabBarItem.selectedImage = systemImageService.image(symbol: .figureWalkCircleFill)

        settingsScreen.tabBarItem.image = systemImageService.image(symbol: .gearshape)
        settingsScreen.tabBarItem.selectedImage = systemImageService.image(symbol: .gearshapeFill)
    }
}

// MARK: - ScreenTabs

extension MainScreenTabs: ScreenTabs {
    var viewControllers: [UIViewController] {
        [
            groupsScreen,
            chatsScreen,
            trainingsScreen,
            settingsScreen
        ]
    }
}
