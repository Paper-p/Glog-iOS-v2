
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
    
    func fetch(){
        provider.request(.hot) { result in
            print(result)
            switch result{
            case let .success(response):
                do{
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(HotModel.self, from: response.data)
                    self.hotFeed = json.list
                } catch{
                    print(error)
                }
            case let .failure(err):
                return print(err.localizedDescription)
            }
        }
    }
}
