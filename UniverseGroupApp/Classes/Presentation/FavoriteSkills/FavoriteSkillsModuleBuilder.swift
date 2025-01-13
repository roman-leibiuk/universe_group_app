//
//  SkillsModuleBuilder.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

enum FavoriteSkillsTransition: Transition {}

final class FavoriteSkillsModuleBuilder {
    static func build(container: AppContainer) -> Module<FavoriteSkillsTransition, UIViewController> {
        let viewModel = FavoriteSkillsViewModel()
        let viewController = FavoriteSkillsViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionObservable: viewModel.transitionObservable)
    }
}
