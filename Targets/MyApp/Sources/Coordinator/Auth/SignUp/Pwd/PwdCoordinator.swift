
import UIKit

class PwdCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = InsertPwdVM(coordinator: self)
        let vc = InsertPwdVC(vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
        case .nickNameIsRequired:
            nickNameIsRequired()
            
        default:
            return
        }
    }
}

private extension PwdCoordinator{
    private func nickNameIsRequired(){
        let vc = NicknameCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
