
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxFlow

protocol postDataProtocol: AnyObject{
    var hotPostData: BehaviorSubject<[HotPostList]> {get set}
    var postListData: BehaviorSubject<[PostList]> {get set}
}

final class MainVM: BaseViewModel, Stepper{
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    private let userProvider = MoyaProvider<UserService>(plugins: [GlogLoggingPlugin()])
    
    weak var hotPostDelegate: postDataProtocol?
    weak var postListDelegate: postDataProtocol?
    
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
                    self.hotPostDelegate?.hotPostData.onNext(json.list ?? .init())
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
    func fetchPostList(completion: @escaping (Result<Bool, Error>) -> (), page: Int) {
        let param = PostListRequest.init(page: page)
        provider.request(.postList(keyword: param)) { result in
            print(result)
            switch result{
            case let .success(response):
                do{
                    let decoder = JSONDecoder().then{
                        $0.dateDecodingStrategy = .formatted(self.dateFormatter)
                    }
                    let json = try decoder.decode(PostListResponse.self, from: response.data)
                    self.postListDelegate?.postListData.onNext(json.list ?? .init())
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
    
    func pushToHotDetail(model: HotPostList){
        steps.accept(GlogStep.detailIsRequired(id: model.id))
    }
    
    func pushToPostDetail(model: PostList){
        steps.accept(GlogStep.detailIsRequired(id: model.id))
    }
    
    func pushToMyPageVC(model: UserProfileResponse){
        steps.accept(GlogStep.myPageIsRequired(nickname: model.nickname))
    }
    
    func pushToMakeFeedVC(){
        steps.accept(GlogStep.makeFeedIsRequired)
    }
}
