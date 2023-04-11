
import UIKit

class MakeFeedCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = MakeFeedVM(coordinator: self)
        let vc = MakeFeedVC(vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
}
