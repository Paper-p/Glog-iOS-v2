
import UIKit
import RxSwift
import RxCocoa

final class InsertNicknameVM: BaseViewModel{
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }

    func transVC(input: Input) {
        input.doneButtonTap.subscribe(
        onNext: pushInsertPwdVC
        ) .disposed(by: disposeBag)
    }
                
    private func pushInsertPwdVC(){
        coordinator
    }
}

extension InsertNicknameVM: ViewModelType{
    
    struct Input {
        let doneButtonTap: Observable<Void>
    }
    
    struct Output {
        
    }
    
}
