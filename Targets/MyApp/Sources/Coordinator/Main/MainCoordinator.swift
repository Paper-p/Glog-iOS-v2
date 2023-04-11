
import UIKit

class MainCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = MainVM(coordinator: self)
        let vc = MainVC(vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
        case .detailIsRequired(let model):
            detailIsRequired(model: model)
        case .myPageIsRequired(let model):
            myPageIsRequired(model: model)
        case .makeFeedIsRequired:
            return makeFeedIsRequired()
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
        vc.startDetailPostVC(model: model)
    }
    
    private func myPageIsRequired(model: UserProfileResponse){
        let vc = MyPageCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startMyPageVC(model: model)
    }
    
    private func makeFeedIsRequired(){
        let vc = MakeFeedCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
