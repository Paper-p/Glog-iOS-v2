
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxFlow

final class SignInVM: BaseViewModel{
    
    private let provider = MoyaProvider<AuthService>()
    
    func success(){
        print("success")
        coordinator.navigate(to: .mainIsRequired)
    }
    
    func failure(){
        print("fail")
    }
    
    func fetch(id: String, pwd: String){
        let param = SignInRequest.init(userId: id, password: pwd)
        print(param)
        
        provider.request(.signIn(param: param)) { response in
            print(response)
            switch response{
            case let .success(result):
                let statusCode = result.statusCode
                switch statusCode{
                case 200..<300:
                    self.success()
                default:
                    self.failure()
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}
