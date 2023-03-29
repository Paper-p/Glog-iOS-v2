
import UIKit
import RxCocoa
import RxSwift
import Moya

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let window: UIWindow?
    
    
    init(navigationCotroller: UINavigationController, window: UIWindow?) {
        self.window = window
        self.navigationController = navigationCotroller
        window?.makeKeyAndVisible()
    }
    
    func start() {
        /*let tk = Keychain()
        let provider = MoyaProvider<AuthService>(plugins: [GlogLoggingPlugin()])
        
        let introVC = IntroCoordinator(navigationController: navigationController)
        let mainVC = MainCoordinator(navigationController: navigationController)
        
        window?.rootViewController = navigationController
        
        provider.request(.refresh) { result in
            switch result{
            case let .success(data):
                let decodeResult = try? JSONDecoder().decode(UserManager.self, from: data.data)
                tk.create("refreshToken", token: decodeResult?.refreshToken ?? "")
                self.start(coordinator: mainVC)
            case let .failure(err):
                self.start(coordinator: introVC)
                print(err.localizedDescription)
            }
        }*/
        
        let vc = IntroCoordinator(navigationController: navigationController)
        window?.rootViewController = navigationController
        start(coordinator: vc)
    }
    
    func start(coordinator: Coordinator) {
        coordinator.start()
    }
    
    func didFinish(coordinator: Coordinator) {
        
    }
    
    func navigate(to step: GlogStep) {
        
    }
    
    func removeChildCoordinators() {
        
    }
    
}
