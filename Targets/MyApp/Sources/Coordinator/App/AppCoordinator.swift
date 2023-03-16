
import UIKit
import RxCocoa
import RxSwift

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let window: UIWindow?
    
    
    init(navigationCotroller: UINavigationController, window: UIWindow?) {
        self.window = window
        self.navigationController = navigationCotroller
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let vc = IntroCoordinator(navigationController: navigationController)
        window?.rootViewController = navigationController
        start(coordinator: vc)
    }
    
    func start(coordinator: Coordinator) {
        coordinator.start()
    }
    
    func didFinish(coordinator: Coordinator) {
        
    }
    
    func navigate(to step: GlogStep) {
        
    }
    
    func removeChildCoordinators() {
        
    }
    
}
