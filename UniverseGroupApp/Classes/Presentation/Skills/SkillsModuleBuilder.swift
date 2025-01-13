//
//  SkillsModuleBuilder.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

enum SkillsTransition: Transition {}

final class SkillsModuleBuilder {
    static func build(container: AppContainer) -> Module<SkillsTransition, UIViewController> {
        let viewModel = SkillsViewModel()
        let viewController = SkillsViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionObservable: viewModel.transitionObservable)
    }
}
