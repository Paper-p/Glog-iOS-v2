
import UIKit
import RxSwift
import RxCocoa
import Moya

final class MainVM: BaseViewModel {
    
    func pushToDetailVC(){
        coordinator.navigate(to: .detailIsRequired)
    }
    var hotFeed: [HotResponse] = []
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    
    let dateFormatter = DateFormatter().then{
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    func fetch(completion : @escaping (Result<Bool, Error>) -> ()){
        provider.request(.hot) { result in
            print(result)
            switch result{
            case let .success(response):
                do{
                    let decoder = JSONDecoder().then{
                        $0.dateDecodingStrategy = .formatted(self.dateFormatter)
                    }
                    let json = try decoder.decode(HotModel.self, from: response.data)
                    self.hotFeed = json.list
                    completion(.success(true))
                } catch{
                    print(error)
                }
            case let .failure(err):
                completion(.success(false))
                return print(err.localizedDescription)
            }
        }
    }
}
