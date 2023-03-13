
import UIKit
import RxSwift
import RxCocoa
import Moya

final class InsertIdVM: BaseViewModel{
    
    private let provider = MoyaProvider<AuthService>(plugins: [GlogLoggingPlugin()])
    var errorLabelIsVisible = Observable(true)
    
    func success(){
        print("success")
        coordinator.navigate(to: .pwdIsRequired)
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
