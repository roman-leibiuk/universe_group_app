//
//  SkillsCoordinator.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

final class SkillsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let container: AppContainer
    
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        skillsScreen()
    }
}

private extension SkillsCoordinator {
    func skillsScreen() {
        let module = SkillsModuleBuilder.build(container: container)
        setRoot(module.viewController)
    }
}
