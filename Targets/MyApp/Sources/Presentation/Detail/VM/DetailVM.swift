
import UIKit
import RxSwift
import RxCocoa
import Moya

final class DetailVM: BaseViewModel {
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    
    func fetchLike(id: Int){
        let param = DetailRequest.init(id: id)
        provider.request(.like(param: param)) { result in
            print(result)
            switch result{
            case let .success(response):
                do{
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(DetailResponse.self, from: response.data)
                } catch{
                    print(error)
                }
            case let .failure(err):
                return print(err.localizedDescription)
            }
        }
    }
}
