
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct MyPageStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return GlogStep.myPageIsRequired
    }
}

class MyPageFlow: Flow {

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
            
        case .myPageIsRequired:
            return myPageIsRequired()
            
        case .mainIsRequired:
            return mainIsRequired()
        default:
            return .none
        }
    }
    
    private func myPageIsRequired() -> FlowContributors{
        let vm = MyPageVM()
        let vc = MyPageVC(vm)
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
