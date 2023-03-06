import RxFlow
import UIKit
import RxSwift
import RxCocoa

struct AppStepper: Stepper {
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    
    init() {}
    
    var initialStep: Step {
        return PaperStep.introIsRequired
    }
}

final class AppFlow: Flow {
    private var rootViewController = UINavigationController()
    
    var root: Presentable {
        return self.rootViewController
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? PaperStep else {return .none}
        
        switch step {
        case .introIsRequired:
            return coordinateToIntro()
        default:
            return .none
        }
    }
    
    private func coordinateToIntro() -> FlowContributors {
        let flow = LogInFlow()
        Flows.use(flow, when: .created) { (root) in
            self.rootViewController = root as! UINavigationController
        }
        return .one(
            flowContributor: .contribute(
                withNextPresentable: flow,
                withNextStepper: OneStepper(withSingleStep: PaperStep.introIsRequired)
        ))
    }
    
}
