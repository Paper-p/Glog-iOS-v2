
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct PwdStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return GlogStep.pwdIsRequired
    }
}

class PwdFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = PwdStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GlogStep else { return .none }
        switch step {
        case .pwdIsRequired:
            return pwdIsRequired()
            
        case .nickNameIsRequired:
            return nickNameIsRequired()
            
        default:
            return .none
        }
    }
    
    private func pwdIsRequired() -> FlowContributors{
        let vm = InsertPwdVM()
        let vc = InsertPwdVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func nickNameIsRequired() -> FlowContributors{
        let vm = InsertNicknameVM()
        let vc = InsertNickNameVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
