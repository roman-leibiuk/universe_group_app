import UIKit
import RxSwift

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    func addChild(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    func setRoot(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController.setViewControllers([viewController], animated: animated)
    }
}
