
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxFlow

final class InsertIdVM: BaseViewModel, Stepper{
    
    private let provider = MoyaProvider<AuthService>(plugins: [GlogLoggingPlugin()])
    
    func success(){
        print("success")
        steps.accept(GlogStep.pwdIsRequired)
    }
    
    func failure(){
        print("fail")
    }
    
    func alreadyExist(){
        print("이미 존재")
    }
    
    func fetch(id: String){
        let param = ValidIdRequest(userId: id)
        print(param)
        
        provider.request(.validId(keyword: param)) { response in
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
}
