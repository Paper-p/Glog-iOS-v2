
import UIKit
import RxSwift
import RxCocoa
import Moya

final class DetailVM: BaseViewModel {
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    private let userProvider = MoyaProvider<UserService>(plugins: [GlogLoggingPlugin()])
    private let CommentProvider = MoyaProvider<CommentService>(plugins: [GlogLoggingPlugin()])
    var detailPost: DetailResponse!
    var myPageData: UserProfileResponse!
    
    let dateFormatter = DateFormatter().then{
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    func myPageVC(nickname: String,completion: @escaping () -> ()){
        let param = UserProfileRequest(nickname: nickname)
        userProvider.request(.userProfile(param: param)) { result in
            print(result)
            switch result{
            case let .success(response):
                do{
                    let decoder = JSONDecoder().then{
                        $0.dateDecodingStrategy = .formatted(self.dateFormatter)
                    }
                    let json = try decoder.decode(UserProfileResponse.self, from: response.data)
                    self.myPageData = json
                    completion()
                } catch{
                    print(error)
                }
            case let .failure(err):
                return print(err.localizedDescription)
            }
        }
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
    
    func detailPost(id: Int) {
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
                } catch{
                    print(error)
                }
            case let .failure(err):
                return print(err.localizedDescription)
            }
        }
    }
    
    func addComment(id: Int, content: String,completion : @escaping () -> ()){
        let param = CommentRequest.init(id: id, content: content)
        CommentProvider.request(.addComment(param: param)) { result in
            switch result{
            case .success:
                self.success()
                completion()
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
    
    func deleteFeed(id: Int, completion : @escaping (Result<Bool, Error>) -> ()){
        let param = DetailRequest.init(id: id)
        provider.request(.deleteFeed(param: param)) { result in
            print(result)
            switch result{
            case .success: completion(.success(true))
            case let.failure(err):
                return print(err.localizedDescription)
            }
        }
    }
    
    func deleteComment(id: Int, completion: @escaping (Result<Bool, Error>) -> ()){
        let param = DeleteCommentRequest.init(id: id)
        CommentProvider.request(.deleteComment(param: param)) { result in
            print(result)
            switch result{
            case .success: completion(.success(true))
            case let .failure(err):
                return print(err.localizedDescription)
            }
        }
    }
    
    func pushToMyPageVC(model: UserProfileResponse){
        coordinator.navigate(to: .myPageIsRequired(model: model))
    }
    
    func pushToMain(){
        coordinator.navigate(to: .mainIsRequired)
    }
    
    func pushToEditFeed(model: DetailResponse){
        coordinator.navigate(to: .editFeedIsRequired(model: model))
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
