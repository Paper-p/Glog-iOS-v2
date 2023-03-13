
import UIKit

class NicknameCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = InsertNicknameVM(coordinator: self)
        let vc = InsertNickNameVC(vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
        case .signInIsRequired:
            signInIsRequired()
            
        default:
            return
        }
    }
}

private extension NicknameCoordinator{
    private func signInIsRequired(){
        let vc = SignInCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
