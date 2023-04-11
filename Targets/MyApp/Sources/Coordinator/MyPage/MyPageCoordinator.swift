
import UIKit

class MyPageCoordinator: BaseCoordinator{
    func startMyPageVC(model: UserProfileResponse){
        let vm = MyPageVM(coordinator: self)
        let vc = MyPageVC(viewModel: vm, model: model)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
