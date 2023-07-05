
import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct IntroStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return GlogStep.introIsRequired
    }
}

class IntroFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = IntroStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GlogStep else { return .none }
        switch step {
        case .introIsRequired:
            return introIsRequired()
            
        case .signInIsRequired:
            return signInIsRequired()
            
        case .idIsRequired:
            return idIsRequired()
            
        case .mainIsRequired:
            return mainIsRequired()
            
        case .makeFeedIsRequired:
            return makeFeedIsRequired()
            
        case let .detailIsRequired(id):
            return detailIsRequired(id: id)
        
        default:
            return .none
        }
    }
    
    
    private func introIsRequired() -> FlowContributors{
        let vm = IntroVM()
        let vc = IntroVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func signInIsRequired() -> FlowContributors{
        let vm = SignInVM()
        let vc = SignInVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func idIsRequired() -> FlowContributors{
        let vm = InsertIdVM()
        let vc = InsertIdVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
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
}
