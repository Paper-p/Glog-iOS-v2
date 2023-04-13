
import UIKit
import RxSwift
import RxCocoa
import Moya

final class MakeFeedVM: BaseViewModel {
    
    func pushToMainVC(){
        coordinator.navigate(to: .mainIsRequired)
    }
    
    private let provider = MoyaProvider<FeedService>(plugins: [GlogLoggingPlugin()])
}
