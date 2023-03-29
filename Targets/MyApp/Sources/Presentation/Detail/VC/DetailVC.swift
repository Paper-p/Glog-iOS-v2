import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class DetailVC: BaseVC<DetailVM>{
    var model: DetailResponse?
    
    private let scrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let titleLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        $0.textAlignment = .left
    }
    
    //private let tagCollectionView = UICollectionView()
    
    private let profileImageView = UIImageView()
    private let authorLabel = UILabel()
    private let createdAtLabel = UILabel()
    private let likeButton = UIButton()
    private let hitButton = UIButton()
    
    private let thumbnailImageView = UIImageView()
    
    private let contentTextView = UITextView()
    
    private let commentCategory = UIView()
    private let commentTextField = UITextField()
    private let commentTableView = UITableView()
    
    override func configureNavigation() {
        self.navigationItem.titleView = UIImageView(image: GlogAsset.Images.paperMainLogo.image.downSample(size: .init(width: 26, height: 26)).withRenderingMode(.alwaysOriginal))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperProfileLogo.image.downSample(size: .init(width: 36, height: 36)).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: .none)
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    init(viewModel: DetailVM, model: DetailResponse) {
        super.init(viewModel)
        self.model = model
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData(with: model!)
        
        scrollView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod(_:)))
    
    override func addView() {
        view.addSubViews(titleLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(120)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(33)
        }
    }
    
    private func bindData(with model: DetailResponse){
        titleLabel.text = model.title
    }
    
    @objc func tapMethod(_ sender: UITapGestureRecognizer) {
       self.view.endEditing(true)
   }
       
}
