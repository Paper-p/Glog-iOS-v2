
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxFlow

final class MakeFeedVM: BaseViewModel, Stepper{
    
    var imageData: imageResponse?
    
    func pushToMainVC(){
        steps.accept(GlogStep.mainIsRequired)
    }
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    private let imageProvider = MoyaProvider<ImageService>(plugins: [GlogLoggingPlugin()])
    
    func fetchMakeFeed(title: String, content: String, thumbnail: String, tags: [String]){
        let param = MakeFeedRequest.init(title: title, content: content, thumbnail: thumbnail, tags: tags)
        provider.request(.makeFeed(param: param)) { result in
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
