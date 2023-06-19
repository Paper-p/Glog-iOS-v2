
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxFlow

final class InsertNicknameVM: BaseViewModel, Stepper{

    private let provider = MoyaProvider<AuthService>(plugins: [GlogLoggingPlugin()])
    
    func success(){
        print("success")
        steps.accept(GlogStep.signInIsRequired)
    }
    
    func signUp(){
        let userInfo = SignUpModel.share
        let param = SignUpRequest(nickname: userInfo.nickname!, userId: userInfo.userId!, password: userInfo.password!)
        
        provider.request(.signUp(param: param)) { response in
            print(response)
            switch response{
            case let .success(result):
                let statusCode = result.statusCode
                switch statusCode{
                case 200..<300:
                    self.success()
                case 409:
                    self.alreadyExist()
                default:
                    self.failure()
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
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
                    self.signUp()
                case 409:
                    self.alreadyExist()
                default:
                    self.failure()
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}
