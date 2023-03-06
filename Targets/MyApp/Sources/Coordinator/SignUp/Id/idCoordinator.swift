import UIKit


class IdCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let window: UIWindow
    
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        window.rootViewController = navigationController
    }
    
    func start() {
        let vm = InsertIdVM(coordinator: self)
        let vc = InsertIdVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToPwd(){
        let vm = InsertPwdVM(coodinator: self)
        let vc = InsertPwdVC(vm)
        navigationControllerl.setViewControllers([vc], animated: true)
    }
}
