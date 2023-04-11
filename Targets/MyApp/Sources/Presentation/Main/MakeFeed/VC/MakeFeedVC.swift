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
    
    private let titleTextfield = UITextField().then{
        $0.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요", attributes: [
            .foregroundColor : GlogAsset.Colors.paperGrayColor.color,
            .font : UIFont.systemFont(ofSize: 26, weight: .bold)])
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: makeButton.imageView?.image, style: .plain, target: self, action: nil)
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Paper_MainLogo")?.withRenderingMode(.alwaysOriginal))
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    override func addView() {
        view.addSubViews(titleTextfield)
    }
    
    override func setLayout() {
        titleTextfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(55)
            make.centerX.equalToSuperview()
        }
    }
}
