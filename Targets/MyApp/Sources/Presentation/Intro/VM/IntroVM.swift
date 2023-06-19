import UIKit
import RxSwift
import RxCocoa
import RxFlow

final class IntroVM: BaseViewModel, Stepper{
    
    func pushToSignInVC(){
        steps.accept(GlogStep.signInIsRequired)
   }
   
   func pushToSignUpVC(){
       steps.accept(GlogStep.idIsRequired)
   }
}
