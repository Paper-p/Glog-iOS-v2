
import UIKit

class MyPageCoordinator: BaseCoordinator{
    func startMyPageVC(){
        let vm = MyPageVM(coordinator: self)
        let vc = MyPageVC(vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
}
