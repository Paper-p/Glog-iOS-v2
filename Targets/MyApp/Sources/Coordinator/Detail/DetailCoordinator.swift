
import UIKit

class DetailCoordinator: BaseCoordinator{
    func startDetailPostVC(model: DetailResponse) {
        let vm = DetailVM(coordinator: self)
        let vc = DetailVC(viewModel: vm, model: model)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
        case let .myPageIsRequired(model):
            return myPageIsRequired(model: model)
        default:
            return
        }
    }
}

extension DetailCoordinator{
    private func myPageIsRequired(model: UserProfileResponse){
        let vc = MyPageCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startMyPageVC(model: model)
    }
}
