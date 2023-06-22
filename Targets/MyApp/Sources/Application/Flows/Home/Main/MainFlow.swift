
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct MainStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return GlogStep.mainIsRequired
    }
}

class MainFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = MainStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GlogStep else { return .none }
        switch step {
        case .mainIsRequired:
            return mainIsRequired()
            
        case .makeFeedIsRequired:
            return makeFeedIsRequired()
            
        case let .detailIsRequired(id):
            return detailIsRequired(id: id)
            
        case let .myPageIsRequired(nickname):
            return myPageIsRequired(nickname: nickname)
            
        default:
            return .none
        }
    }
    
    private func mainIsRequired() -> FlowContributors{
        let vm = MainVM()
        let vc = MainVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func makeFeedIsRequired() -> FlowContributors{
        let vm = MakeFeedVM()
        let vc = MakeFeedVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func detailIsRequired(id: Int) -> FlowContributors{
        let vm = DetailVM(id: id)
        let vc = DetailVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func myPageIsRequired(nickname: String) -> FlowContributors{
        let vm = MyPageVM(nickname: nickname)
        let vc = MyPageVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
