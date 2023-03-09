
import UIKit
import RxSwift
import RxCocoa

class BaseViewModel {
    let coordinator: BaseCoordinator
        
    init(coordinator: BaseCoordinator){
        self.coordinator = coordinator
    }
}
