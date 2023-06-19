
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct SignInStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return GlogStep.signInIsRequired
    }
}

class SignInFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = SignInStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GlogStep else { return .none }
        switch step {
        case .signInIsRequired:
            return signInIsRequired()
            
        case .mainIsRequired:
            return mainIsRequired()
        
        default:
            return .none
        }
    }
    
    private func signInIsRequired() -> FlowContributors{
        let vm = SignInVM()
        let vc = SignInVC(vm)
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
