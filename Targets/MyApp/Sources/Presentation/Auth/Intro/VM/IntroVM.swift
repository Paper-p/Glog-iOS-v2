import UIKit
import RxSwift
import RxCocoa

final class IntroVM: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }

    func transVC(input: Input) {
        input.signInButtonTap.subscribe(
        onNext: pushSignInVC
        ) .disposed(by: disposeBag)
        
        input.signUpButtonTap.subscribe(
        onNext: pushSignUpVC
        ) .disposed(by: disposeBag)
    }
    
    private func pushSignInVC() {
        coordinator.pushSignInVC()
    }
    private func pushSignUpVC() {
        coordinator.pushSignUpVC()
    }
    
}
extension IntroVM: ViewModelType{
    
    struct Input {
        let signInButtonTap: Observable<Void>
        let signUpButtonTap: Observable<Void>
    }
    
    struct Output {
        
    }
    
}
