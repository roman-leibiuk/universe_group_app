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
    }
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let container: AppContainer
    
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
    
    }
}

private extension TabBarCoordinator {
    func setupSkillCoordinator() {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(
            title: "Skills",
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
            title: "Favorite skills",
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
}
