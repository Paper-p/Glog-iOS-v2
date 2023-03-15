import UIKit
import RxSwift
import RxCocoa
import RxFlow

final class IntroVM: BaseViewModel {
    
    func pushToSignInVC(){
        coordinator.navigate(to: .signInIsRequired)
    }
    
    func pushToSignUpVC(){
        coordinator.navigate(to: .idIsRequired)
    }
}
