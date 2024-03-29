
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxFlow

final class SignInVM: BaseViewModel, Stepper{
    
    private let provider = MoyaProvider<AuthService>(plugins: [GlogLoggingPlugin()])
    private let tk = Keychain()
    
    func success(){
        print("success")
        steps.accept(GlogStep.mainIsRequired)
    }
    
    func failure(){
        print("fail")
    }
    
    func fetch(completion : @escaping (Result<Bool, Error>) -> (), id: String, pwd: String){
        let param = SignInRequest.init(userId: id, password: pwd)
        print(param)
        
        provider.request(.signIn(param: param)) { result in
            print(result)
            switch result{
            case let .success(response):
                let statusCode = response.statusCode
                switch statusCode{
                case 200..<300:
                    if let refreshToken = (try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any])? ["refreshToken"] as? String{
                        self.tk.create("refreshToken", token: refreshToken)
                    }
                    if let accessToken = (try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any])? ["accessToken"] as? String{
                        self.tk.create("accessToken", token: accessToken)
                    }
                    self.success()
                    completion(.success(true))
                case 400..<404:
                    return self.failure()
                default:
                    return self.failure()
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}
