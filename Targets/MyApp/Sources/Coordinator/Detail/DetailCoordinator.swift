
import UIKit

class DetailCoordinator: BaseCoordinator{
    func startDetailPost(model: DetailResponse) {
        let vm = DetailVM(coordinator: self)
        let vc = DetailVC(vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
