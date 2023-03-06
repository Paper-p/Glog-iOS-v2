
import UIKit
import RxSwift
import RxCocoa

final class InsertPwdVM: BaseViewModel{
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }

    func transVC(input: Input) {
        input.nextButtonTap.subscribe(
        onNext: pushInsertPwdVC
        ) .disposed(by: disposeBag)
    }
                
    private func pushInsertPwdVC(){
        coordinator.pushPwdVC()
    }
}

extension InsertPwdVM: ViewModelType{
    
    struct Input {
        let nextButtonTap: Observable<Void>
    }
    
    struct Output {
        
    }
    
}
