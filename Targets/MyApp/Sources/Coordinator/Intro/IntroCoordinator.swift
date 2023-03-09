
import UIKit

class IntroCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = IntroVM(coordinator: self)
        let vc = IntroVC(vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
        case .signInIsRequired:
            signInIsRequired()
            
        case .idIsRequired:
            
            
        default:
            return
        }
    }
}

private extension IntroCoordinator{
    private func signInIsRequired(){
        let vc = SignInCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
    
    private func idIsRequired(){
        let vc = 
    }
}
