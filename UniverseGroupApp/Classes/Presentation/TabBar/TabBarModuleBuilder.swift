//
//  TabBarModuleBuilder.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

enum TabBarTransition: Transition {}

final class TabBarModuleBuilder {
    static func build(viewControllers: [UIViewController]) -> Module<TabBarTransition, UIViewController> {
        let viewModel = TabBarViewModel()
        let viewController = TabBarViewController(viewModel: viewModel, viewControllers: viewControllers)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
