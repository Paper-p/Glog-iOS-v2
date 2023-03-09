
import UIKit

class SignInCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = SignInVM(coordinator: self)
        let vc = SignInVC(vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
        case .mainIsRequired:
            mainIsRequired()
        default:
            return
        }
    }
}

private extension SignInCoordinator{
    private func mainIsRequired(){
        let vc = MainCoordinator(navigationController: navigationController)
        vc.start(coordinator: vc)
    }
}
