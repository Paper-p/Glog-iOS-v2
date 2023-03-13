
import UIKit

class MainCoordinator: BaseCoordinator{
    
    override func start() {
        let vm = MainVM(coordinator: self)
        let vc = MainVC(vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    override func navigate(to step: GlogStep) {
        switch step{
            
        default:
            return
        }
    }
}

private extension MainCoordinator{
    
}