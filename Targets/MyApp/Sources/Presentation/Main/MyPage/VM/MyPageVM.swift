
import UIKit
import RxSwift
import RxCocoa
import Moya


final class MyPageVM: BaseViewModel{
    
    func pushToDetailVC(model: DetailResponse){
        coordinator.navigate(to: .detailIsRequired(model: model))
    }
    
    var detailPost: DetailResponse!
    var imageData: imageResponse?
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    private let userProvider = MoyaProvider<UserService>(plugins: [GlogLoggingPlugin()])
    private let imageProvider = MoyaProvider<ImageService>(plugins: [GlogLoggingPlugin()])
    
    let dateFormatter = DateFormatter().then{
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
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
    
    func patchNickname(nickname: String){
        let param = EditNicknameRequest.init(nickname: nickname)
        userProvider.request(.editNickname(param: param)) { result in
            print(result)
        }
    }
    
    func patchProfileImage(imageUrl: String){
        let param = EditProfileImageRequest.init(imageUrl: imageUrl)
        userProvider.request(.editProfileImage(param: param)) { result in
            print(result)
        }
    }
    
    func uploadImage(image: UIImage){
        imageProvider.request(.uploadImage(image: image)) { result in
            print(result)
            switch result{
            case let .success(response):
                do{
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(imageResponse.self, from: response.data)
                    self.imageData = json
                } catch{
                    print(error)
                }
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }
}
