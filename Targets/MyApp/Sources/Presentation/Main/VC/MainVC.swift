import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit

final class MainVC: BaseVC<MainVM>{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addView() {
        
    }
    
    override func configureNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperMainLogo.image, style: .plain, target: self, action: .none)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperProfileLogo.image.downsam, style: .plain, target: self, action: .none)
    }
    
    override func setLayout() {
        
    }
    
    @objc func profileButtonDidTap(){
        
    }
}
