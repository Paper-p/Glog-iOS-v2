import Foundation
import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Kingfisher
import Gifu

final class MakeFeedVC: BaseVC<MakeFeedVM>{
    
    private let makeButton = UIButton().then{
        $0.setImage(UIImage(systemName: "pencil.line")?.tintColor(GlogAsset.Colors.paperStartColor.color), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: makeButton.imageView?.image, style: .plain, target: self, action: nil)
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
}
