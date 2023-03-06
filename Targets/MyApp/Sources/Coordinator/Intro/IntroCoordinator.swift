
import UIKit


class IntroCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let window: UIWindow
    
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        window.rootViewController = navigationController
    }
    
    func start() {
        let vm = IntroVM(coordinator: self)
        let vc = IntroVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
        
    func pushSignInVC() {
        let vm = SignInVM(coordinator: self)
        let vc = SignInVC(vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushSignUpVC() {
        let vm = InsertIdVM(coordinator: self)
        let vc = InsertIdVC(vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
