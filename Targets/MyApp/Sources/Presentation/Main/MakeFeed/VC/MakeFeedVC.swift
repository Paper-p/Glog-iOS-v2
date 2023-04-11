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
    
    private let scrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let makeButton = UIButton().then{
        $0.setImage(UIImage(systemName: "pencil.line")?.tintColor(GlogAsset.Colors.paperStartColor.color), for: .normal)
    }
    
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func configureNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: makeButton.imageView?.image, style: .plain, target: self, action: nil)
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews()
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.width.top.bottom.equalToSuperview()
        }
    }
    
    @objc func tapMethod(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
