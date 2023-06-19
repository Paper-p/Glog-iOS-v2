
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct NickNameStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return GlogStep.nickNameIsRequired
    }
}

class NickNameFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = NickNameStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GlogStep else { return .none }
        switch step {
            
        case .nickNameIsRequired:
            return nickNameIsRequired()
            
        case .signInIsRequired:
            return signInIsRequired()
            
        default:
            return .none
        }
    }
    
    private func nickNameIsRequired() -> FlowContributors{
        let vm = InsertNicknameVM()
        let vc = InsertNickNameVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func signInIsRequired() -> FlowContributors{
        let vm = SignInVM()
        let vc = SignInVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }

}
