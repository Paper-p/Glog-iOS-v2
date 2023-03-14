
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
        
        provider.request(.signIn(param: param)) { response in
            print(response)
            switch response{
            case let .success(result):
                let decodeResult = try? JSONDecoder().decode(SignInResponse.self, from: result.data)
                self.tk.create("accessToken", token: decodeResult?.accessToken ?? "")
                self.tk.create("refreshToken", token: decodeResult?.refreshToken ?? "")
                self.success()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}
