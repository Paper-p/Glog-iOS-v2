
import UIKit
import RxSwift
import RxCocoa

final class InsertPwdVM: BaseViewModel{
    
    func pushToNicknameVC() {
        coordinator.navigate(to: .nickNameIsRequired)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^.*(?=^.{8,15}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
}
