//
//  TabBarCoordinator.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    enum Constants {
        static let starImageName = "star"
        static let heartImageName = "heart"
        static let skillsTitle = "skills".localized()
        static let favoriteSkillsTitle = "favoriteSkills".localized()
    }
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let container: AppContainer
    
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        setupSkillCoordinator()
        setupFavoriteSkillCoordinator()
        setupTabBar()
    }
}

private extension TabBarCoordinator {
    func setupSkillCoordinator() {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(
            title: Constants.skillsTitle,
            image: UIImage(systemName: Constants.starImageName),
            tag: 0
        )
        
        let coordinator = SkillsCoordinator(
            navigationController: navigationController,
            container: container
        )
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func setupFavoriteSkillCoordinator() {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(
            title: Constants.favoriteSkillsTitle,
            image: UIImage(systemName: Constants.heartImageName),
            tag: 1
        )
        
        let coordinator = FavoriteSkillsCoordinator(
            navigationController: navigationController,
            container: container
        )
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func setupTabBar() {
        let viewControllers = childCoordinators.compactMap { $0.navigationController }
        let module = TabBarModuleBuilder.build(viewControllers: viewControllers)
        setRoot(module.viewController)
    }
}
