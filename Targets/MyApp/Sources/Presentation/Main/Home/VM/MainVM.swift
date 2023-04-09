
import UIKit
import RxSwift
import RxCocoa
import Moya

final class MainVM: BaseViewModel {
    
    func pushToDetailVC(model: DetailResponse){
        coordinator.navigate(to: .detailIsRequired(model: model))
    }
    
    var hotFeed: [HotResponse] = []
    var postList: [PostList] = []
    var detailPost: DetailResponse!
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    
    let dateFormatter = DateFormatter().then{
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    func fetchHotPostList(completion : @escaping (Result<Bool, Error>) -> ()){
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
    func fetchPostList(completion: @escaping (Result<Bool, Error>) -> (), search: String?) {
        let param = PostListRequest.init(keyword: search!)
        provider.request(.postList(keyword: param)) { result in
            print(result)
            switch result{
            case let .success(response):
                do{
                    let decoder = JSONDecoder().then{
                        $0.dateDecodingStrategy = .formatted(self.dateFormatter)
                    }
                    let json = try decoder.decode(PostListResponse.self, from: response.data)
                    self.postList = json.list
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
    
    func detailPost(completion: @escaping (Result<Bool, Error>) -> (), id: Int) {
        let param = DetailRequest.init(id: id)
        provider.request(.detail(param: param)) { result in
            print(result)
            switch result{
            case let .success(response):
                do{
                    let decoder = JSONDecoder().then{
                        $0.dateDecodingStrategy = .formatted(self.dateFormatter)
                    }
                    let json = try decoder.decode(DetailResponse.self, from: response.data)
                    self.detailPost = json
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
