
import UIKit
import RxSwift
import RxCocoa

final class SignInVM: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }

    func transVC(input: Input) {
        input.signInButtonTap.subscribe(
        onNext: pushMainVC
        ) .disposed(by: disposeBag)
    }
    
    private func pushMainVC() {
        coordinator.pushMainVC()
    }
}
extension SignInVM: ViewModelType{
    
    struct Input {
        let signInButtonTap: Observable<Void>
    }
    
    struct Output {
        
    }
    
}
