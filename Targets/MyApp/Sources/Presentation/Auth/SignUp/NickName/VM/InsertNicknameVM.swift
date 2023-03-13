
import UIKit
import RxSwift
import RxCocoa
import Moya

final class InsertNicknameVM: BaseViewModel{

    private let provider = MoyaProvider<AuthService>(plugins: [GlogLoggingPlugin()])
    var errorLabelIsVisible = Observable(true)
    
    func success(){
        print("success")
        coordinator.navigate(to: .signInIsRequired)
    }
    
    func failure(){
        print("fail")
    }
    
    func alreadyExist(){
        print("이미 존재")
    }
    
    func fetch(nickname: String){
        let param = ValidNameRequest(nickname: nickname)
        print(param)
        
        provider.request(.validNickname(keyword: param)) { response in
            print(response)
            switch response{
            case let .success(result):
                let statusCode = result.statusCode
                switch statusCode{
                case 200..<300:
                    self.success()
                    self.errorLabelIsVisible.value = true
                case 409:
                    self.alreadyExist()
                    self.errorLabelIsVisible.value = false
                default:
                    self.failure()
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}
