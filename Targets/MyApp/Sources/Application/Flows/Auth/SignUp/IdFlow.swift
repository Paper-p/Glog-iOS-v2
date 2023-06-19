
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct IdStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return GlogStep.idIsRequired
    }
}

class IdFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = IdStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GlogStep else { return .none }
        switch step {
        case .idIsRequired:
            return idIsRequired()
        
        case .pwdIsRequired:
            return pwdIsRequired()
            
        default:
            return .none
        }
    }
    
    private func idIsRequired() -> FlowContributors{
        let vm = InsertIdVM()
        let vc = InsertIdVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func pwdIsRequired() -> FlowContributors{
        let vm = InsertPwdVM()
        let vc = InsertPwdVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
