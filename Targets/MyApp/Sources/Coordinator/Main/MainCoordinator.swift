
import UIKit

class MainCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = MainVM(coordinator: self)
        let vc = MainVC(vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
        case let .detailIsRequired(model):
            detailIsRequired(model: model)
        default:
            return
        }
    }
}

private extension MainCoordinator{
    private func detailIsRequired(model: DetailResponse){
        let vc = DetailCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startDetailPost(model: model)
    }
}
