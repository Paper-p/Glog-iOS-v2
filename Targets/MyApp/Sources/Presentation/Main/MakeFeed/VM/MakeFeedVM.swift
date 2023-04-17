
import UIKit
import RxSwift
import RxCocoa
import Moya

final class MakeFeedVM: BaseViewModel {
    
    func pushToMainVC(){
        coordinator.navigate(to: .mainIsRequired)
    }
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
    
    func fetchMakeFeed(title: String, content: String, thumbnail: String, tags: [String]){
        let param = MakeFeedRequest.init(title: title, content: content, thumbnail: thumbnail, tags: tags)
        provider.request(.makeFeed(param: param)) { result in
            print(result)
        }
    }
}
