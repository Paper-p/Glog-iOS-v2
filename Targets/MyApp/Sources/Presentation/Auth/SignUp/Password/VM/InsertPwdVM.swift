
import UIKit
import RxSwift
import RxCocoa
import RxFlow

final class InsertPwdVM: BaseViewModel, Stepper{
    
    func pushToNicknameVC() {
        steps.accept(GlogStep.nickNameIsRequired)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx =  "(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
}
