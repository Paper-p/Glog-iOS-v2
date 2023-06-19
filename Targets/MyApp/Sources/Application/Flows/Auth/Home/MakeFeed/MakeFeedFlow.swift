
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct MakeFeedStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return GlogStep.makeFeedIsRequired
    }
}

class MakeFeedFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = MakeFeedStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GlogStep else { return .none }
        switch step {
            
        case .makeFeedIsRequired:
            return makeFeedIsRequired()
            
        case .mainIsRequired:
            return mainIsRequired()
        default:
            return .none
        }
    }
    
    private func makeFeedIsRequired() -> FlowContributors{
        let vm = MakeFeedVM()
        let vc = MakeFeedVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }

    private func mainIsRequired() -> FlowContributors{
        let vm = MainVM()
        let vc = MainVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
