
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxFlow

final class MyPageVM: BaseViewModel, Stepper{
    
    var mypageData: UserProfileResponse?
    var imageData: imageResponse?
    
    private let userProvider = MoyaProvider<UserService>(plugins: [GlogLoggingPlugin()])
    private let imageProvider = MoyaProvider<ImageService>(plugins: [GlogLoggingPlugin()])
    
    func fetchMyPage(completion: @escaping (Result<Bool,Error>) -> (), nickname: String){
        let param = UserProfileRequest.init(nickname: nickname)
        userProvider.request(.userProfile(param: param)) { result in
            print(result)
            switch result{
            case let .success(response):
                do{
                    let json = try JSONDecoder().decode(UserProfileResponse.self, from: response.data)
                    self.mypageData = json
                } catch {
                    print(error)
                }
            case let .failure(err):
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
    
    func pushToDetailVC(model: DetailResponse){
        steps.accept(GlogStep.detailIsRequired(id: model.id))
    }
}
