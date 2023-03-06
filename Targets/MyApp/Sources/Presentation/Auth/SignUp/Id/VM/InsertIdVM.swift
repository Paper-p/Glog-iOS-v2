
import UIKit
import RxSwift
import RxCocoa

final class InsertIdVM: BaseViewModel{
    var coordinator: IdCoordinator
    
    init(coordinator: IdCoordinator){
        self.coordinator = coordinator
    }

    func transVC(input: Input) {
        input.nextButtonTap.subscribe(
        onNext: pushInsertPwdVC
        ) .disposed(by: disposeBag)
    }
                
    private func pushInsertPwdVC(){
        coordinator.pushToPwd()
    }
}

extension InsertIdVM: ViewModelType{
    
    struct Input {
        let nextButtonTap: Observable<Void>
    }
    
    struct Output {
        
    }
    
}
