
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxFlow

final class SignInVM: BaseViewModel{
    
    private let provider = MoyaProvider<AuthService>()
    private let tk = Keychain()
    
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
        
        provider.request(.signIn(param: param)) { result in
            print(result)
            switch result{
            case let .success(response):
                let decodeResult = try? JSONDecoder().decode(SignInResponse.self, from: response.data)
                
                if let refreshToken = (try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any])? ["refreshToken"] as? String{
                    self.tk.create("refreshToken", token: refreshToken)
                }
                if let accessToken = (try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any])? ["accessToken"] as? String{
                    self.tk.create("accessToken", token: accessToken)
                }
                self.success()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}
