
import UIKit
import RxSwift
import RxCocoa
import Moya

final class DetailVM: BaseViewModel {
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    var detailPost: DetailResponse!
    
    func fetchLike(id: Int, completion : @escaping (Result<Bool, Error>) -> ()){
        let param = DetailRequest.init(id: id)
        provider.request(.like(param: param)) { result in
            print(result)
            switch result{
            case .success: completion(.success(true))
            case let .failure(err):
                return print(err.localizedDescription)
            }
        }
    }
    
    func fetchCancelLike(id: Int, completion : @escaping (Result<Bool, Error>) -> ()){
        let param = DetailRequest.init(id: id)
        provider.request(.cancelLike(param: param)) { result in
            print(result)
            switch result{
            case .success: completion(.success(true))
            case let.failure(err):
                return print(err.localizedDescription)
            }
        }
    }
}
