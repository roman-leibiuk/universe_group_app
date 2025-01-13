//
//  SplashCoordinator.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit
import RxSwift

final class SplashCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let container: AppContainer
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        splashScreen()
    }
}

private extension SplashCoordinator {
    func splashScreen() {
        let module = SplashModuleBuilder.build(container: container)
        module.transitionPublisher
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] transition in
                switch transition {
                case .tabBar:
                    tabBarCoordinator()
                }
            })
            .disposed(by: disposeBag)
        
        setRoot(module.viewController)
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
