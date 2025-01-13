//
//  AppCoordinator.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    var window: UIWindow?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let container: AppContainer

    init(
        window: UIWindow?,
        container: AppContainer,
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.window = window
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        splashScreen()
    }
}

private extension AppCoordinator {
    func splashScreen() {
        let coordinator = SplashCoordinator(
            navigationController: navigationController,
            container: container
        )
        coordinator.start()
    }
}
