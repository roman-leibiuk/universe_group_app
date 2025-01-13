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
    var didFinishPublisher: PublishSubject<Void> = .init()
    
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
        module.transitionObservable
            .subscribe(onNext: { [unowned self] transition in
                switch transition {
                case .tabBar:
                    didFinishPublisher.onNext(())
                    didFinishPublisher.onCompleted()
                }
            })
            .disposed(by: disposeBag)
        
        setRoot(module.viewController)
    }
}
