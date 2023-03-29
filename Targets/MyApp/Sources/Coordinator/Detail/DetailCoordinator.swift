
import UIKit

class DetailCoordinator: BaseCoordinator{
    func startDetailPostVC(model: DetailResponse) {
        let vm = DetailVM(coordinator: self)
        let vc = DetailVC(viewModel: vm, model: model)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
