//
//  SplashModuleBuilder.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

enum SplashTransition: Transition {
    case tabBar
}

final class SplashModuleBuilder {
    static func build(container: AppContainer) -> Module<SplashTransition, UIViewController> {
        let viewModel = SplashViewModel(skillsService: container.skillsService)
        let viewController = SplashViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionObservable: viewModel.transitionObservable)
    }
}
