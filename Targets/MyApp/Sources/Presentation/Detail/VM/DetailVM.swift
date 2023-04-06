
import UIKit
import RxSwift
import RxCocoa
import Moya

final class DetailVM: BaseViewModel {
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    private let CommentProvider = MoyaProvider<CommentService>(plugins: [GlogLoggingPlugin()])
    var detailPost: DetailResponse!
    
    let dateFormatter = DateFormatter().then{
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
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
    
    func addComment(id: Int, content: String,completion : @escaping (Result<Bool, Error>) -> ()){
        let param = CommentRequest.init(id: id, content: content)
        CommentProvider.request(.addComment(param: param)) { result in
            switch result{
            case .success:
                self.success()
                completion(.success(true))
            case let .failure(err):
                print(err.localizedDescription)
                completion(.success(false))
            }
        }
    }
    
    func success(){
        print("good")
    }
    func badRequest(){
        print("bad")
    }
    func notFound(){
        print("not Found")
    }
}
