//
//  AppCoordinator.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit
import RxSwift

final class AppCoordinator: Coordinator {
    var window: UIWindow?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let disposeBag = DisposeBag()
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

extension AppCoordinator {
    func splashScreen() {
        let coordinator = SplashCoordinator(
            navigationController: navigationController,
            container: container
        )
        childCoordinators.append(coordinator)
        coordinator.didFinishPublisher.subscribe(onNext: { [unowned self] in
            tabBarCoordinator()
            removeChild(coordinator: coordinator)
        })
        .disposed(by: disposeBag)
        coordinator.start()
    }
    
    func tabBarCoordinator() {
        let coordinator = TabBarCoordinator(
            navigationController: navigationController,
            container: container
        )
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
