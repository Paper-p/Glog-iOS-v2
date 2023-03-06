
import RxFlow
import UIKit

class LoginFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init() {}

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GlogStep else { return .none }
        switch step {
        case .introIsRequired:
            return self.coordinateToIntro()
        case .signInIsRequired:
            return self.navigateToSignIn()
        case .mainIsRequired:
            return self.navigateToMain()
        case .idIsRequired:
            return self.navigateToId()
        case .pwdIsRequired:
            return self.navigateToPwd()
        case .nickNameIsRequired:
            return self.navigateToNickname()
        default:
            return .none
        }
    }
    
    private func coordinateToIntro() -> FlowContributors {
        let vm = IntroVM()
        let vc = IntroVC(vm)
        self.rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    
    private func navigateToSignIn() -> FlowContributors {
        let vm = SignInVM()
        let vc = SignInVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    
    private func navigateToId() -> FlowContributors {
        let vm = InsertIdVM()
        let vc = InsertIdVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    
    private func navigateToPwd() -> FlowContributors {
        let vm = InsertPwdVM()
        let vc = InsertPwdVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    
    private func navigateToNickname() -> FlowContributors {
        let vm = InsertNicknameVM()
        let vc = InsertNickNameVC(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    
    private func navigateToMain() -> FlowContributors {
        /*let vm = ()
        let vc = MainViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNext: vc))*/
    }
}
