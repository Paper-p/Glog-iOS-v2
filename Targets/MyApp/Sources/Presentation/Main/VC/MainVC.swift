import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit

final class MainVC: BaseVC<MainVM>, Stepper{
    
    var steps = PublishRelay<Step>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addView() {
        
    }
    
    override func setLayout() {
        
    }
}
