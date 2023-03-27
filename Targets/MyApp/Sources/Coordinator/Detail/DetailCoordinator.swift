
import UIKit

class DetailCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = DetailVC(coordinator: self)
        let vc = DetailVC(vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
            
        default:
            return
        }
    }
}

private extension DetailCoordinator{
    
}
