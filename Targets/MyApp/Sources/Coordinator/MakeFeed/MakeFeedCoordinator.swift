
import UIKit

class MakeFeedCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = MakeFeedVM(coordinator: self)
        let vc = MakeFeedVC(vm)
        
        navigationController.pushViewController(vc, animated: true)
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

private extension MakeFeedCoordinator{
    private func mainIsRequired(){
        let vc = MainCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
