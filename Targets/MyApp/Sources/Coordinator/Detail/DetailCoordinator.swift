
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
        case .mainIsRequired:
            return mainIsRequired()
        case let .editFeedIsRequired(model):
            return editFeedIsRequired(model: model)
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
    
    private func mainIsRequired(){
        let vc = MainCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
    
    private func editFeedIsRequired(model: DetailResponse){
        let vc = MakeFeedCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
