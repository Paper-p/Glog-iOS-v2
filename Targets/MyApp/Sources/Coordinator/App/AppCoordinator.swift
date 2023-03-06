
import UIKit
import RxCocoa
import RxSwift

class MainCoordinator:Coordinator {
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
    
    func pushToSignInVC(){
        let vm = SignInVM(coordinator: self)
        let vc = SignInVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToIdVC(){
        let vm = InsertIdVM(coordinator: self)
        let vc = InsertIdVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToPwdVC(){
        let vm = InsertPwdVM(coordinator: self)
        let vc = InsertPwdVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToNicknameVC(){
        let vm = InsertNicknameVM(coordinator: self)
        let vc = InsertNickNameVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToMain(){
        
    }
}
