
import UIKit
import RxSwift
import RxCocoa

final class SignInVM: BaseViewModel {
    var coordinator: IntroCoordinator
    
    init(coordinator: IntroCoordinator){
        self.coordinator = coordinator
    }

    func transVC(input: Input) {
        input.signInButtonTap.subscribe(
        onNext: pushSignInVC
        ) .disposed(by: disposeBag)
    }
    
    private func pushSignInVC() {
        coordinator.pushSignInVC()
    }
}
extension SignInVM: ViewModelType{
    
    struct Input {
        let signInButtonTap: Observable<Void>
    }
    
    struct Output {
        
    }
    
}
