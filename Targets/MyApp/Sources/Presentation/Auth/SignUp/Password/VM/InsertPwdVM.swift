
import UIKit
import RxSwift
import RxCocoa

final class InsertPwdVM: BaseViewModel{
    
    func pushToNicknameVC() {
        coordinator.navigate(to: .nickNameIsRequired)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx =  "(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
}
