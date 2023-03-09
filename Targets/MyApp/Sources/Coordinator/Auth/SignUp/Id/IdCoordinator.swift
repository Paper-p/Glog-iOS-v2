
import UIKit

class idCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = InsertIdVM(coordinator: self)
        let vc = InsertIdVC(vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
        case .pwdIsRequired:
            pwdIsRequired()
            
        default:
            return
        }
    }
}

private extension idCoordinator{
    private func pwdIsRequired(){
        let vc = PwdCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
