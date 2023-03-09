
import UIKit
import RxSwift
import RxCocoa
import Moya

final class InsertIdVM: BaseViewModel{
    
    private let provider = MoyaProvider<AuthService>()
    
    func success(){
        print("success")
        coordinator.navigate(to: .pwdIsRequired)
    }
    
    func failure(){
        print("fail")
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
                default:
                    self.failure()
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}
