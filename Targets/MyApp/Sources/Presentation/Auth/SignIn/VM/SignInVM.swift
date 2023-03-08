
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxFlow

final class SignInVM: BaseViewModel, Stepper{
    
    let steps = PublishRelay<Step>()
    
    private let provider = MoyaProvider<AuthService>()
    
    private func success(){
        print("success")
        self.steps.accept(GlogStep.mainIsRequired)
    }
    
    private func failure(){
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
