
import UIKit

class MyPageCoordinator: BaseCoordinator{
    func startMyPageVC(model: UserProfileResponse){
        let vm = MyPageVM(coordinator: self)
        let vc = MyPageVC(viewModel: vm, model: model)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
        case .detailIsRequired(let model):
            detailIsRequired(model: model)
        default:
            return
        }
    }
}

private extension MyPageCoordinator{
    private func detailIsRequired(model: DetailResponse){
        let vc = DetailCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startDetailPostVC(model: model)
    }
}
