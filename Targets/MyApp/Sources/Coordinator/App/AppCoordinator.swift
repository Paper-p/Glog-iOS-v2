
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
        let vm = IntroVM()
        let vc = IntroVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToSignInVC(){
        let vm = SignInVM()
        let vc = SignInVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToIdVC(){
        let vm = InsertIdVM()
        let vc = InsertIdVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToPwdVC(){
        let vm = InsertPwdVM()
        let vc = InsertPwdVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToNicknameVC(){
        let vm = InsertNicknameVM()
        let vc = InsertNickNameVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func pushToMain(){
        let vm = MainVM()
        let vc = MainVC(vm)
        navigationController.setViewControllers([vc], animated: true)
    }
}
