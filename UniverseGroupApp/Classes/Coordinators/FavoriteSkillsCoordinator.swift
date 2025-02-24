//
//  FavoriteSkillsCoordinator.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

final class FavoriteSkillsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let container: AppContainer
    
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        favoriteSkillsScreen()
    }
}

private extension FavoriteSkillsCoordinator {
    func favoriteSkillsScreen() {
        let module = FavoriteSkillsModuleBuilder.build(container: container)
        setRoot(module.viewController)
    }
}
