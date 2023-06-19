import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Kingfisher
import Gifu

final class MainVC: BaseVC<MainVM>, postDataProtocol{
    
    var hotPostData = BehaviorSubject<[HotPostList]>(value: [])
    var postListData = BehaviorSubject<[PostList]>(value: [])
    
    var page = 0
    
    private let mainLabel = UILabel().then{
        $0.text = "Glog에서 너의 생각을 펼쳐봐!"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
    }
    
    private let rocketImageView = UIImageView(image: UIImage(named: "Paper_Rocket"))
    
    private let makeFeedButton = UIButton().then{
        $0.setTitle("글쓰러가기", for: .normal)
        $0.setTitleColor(GlogAsset.Colors.paperGrayColor.color, for: .normal)
        $0.addTarget(self, action: #selector(makeFeedButtonDidTap), for: .touchUpInside)
        $0.sizeToFit()
    }
    
    private let hotCategory = UITextView().then{
        $0.backgroundColor = GlogAsset.Colors.paperBlankColor.color
        $0.layer.cornerRadius = 10
        $0.text = "🔥인기"
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.isSelectable = false
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.textContainerInset = .init(top: 6, left: 9, bottom: 6, right: 9)
        $0.sizeToFit()
    }
    
    private let postCategory = UITextView().then{
        $0.backgroundColor = GlogAsset.Colors.paperBlankColor.color
        $0.layer.cornerRadius = 10
        $0.text = "💻 게시물"
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        $0.isSelectable = false
        $0.isEditable = false
        $0.sizeToFit()
    }
    
    private var hotCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        $0.register(HotCollectionViewCell.self, forCellWithReuseIdentifier: HotCollectionViewCell.identifier)
    }
    private var postCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init()).then{
        $0.register(PostListCollectionViewCell.self, forCellWithReuseIdentifier: PostListCollectionViewCell.identifier)
    }
    
    private let segmentedControl = UISegmentedControl(items: [UIImage(systemName: "circle.grid.2x2.fill") ?? "", UIImage(systemName: "line.3.horizontal") ?? "", UIImage(systemName: "square.fill") ?? ""]).then{
        $0.selectedSegmentTintColor = GlogAsset.Colors.paperStartColor.color
        $0.selectedSegmentIndex = 2
    }
    
    private let profileImage = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.postCollectionView.reloadData()
        }
    }
    
    override func setup() {
        viewModel.hotPostDelegate = self
        hotPostData.bind(to: hotCollectionView.rx.items(cellIdentifier: HotCollectionViewCell.identifier, cellType: HotCollectionViewCell.self)){
            (row, data, cell) in
            cell.bind(with: data)
        }.disposed(by: disposeBag)
        
        hotCollectionView.rx.modelSelected(HotPostList.self)
            .asDriver()
            .drive(with: self, onNext: { owner, hot in
                owner.viewModel.pushToHotDetail(model: hot)
            }).disposed(by: disposeBag)
        
        viewModel.postListDelegate = self
        postListData.bind(to: postCollectionView.rx.items(cellIdentifier: PostListCollectionViewCell.identifier, cellType: PostListCollectionViewCell.self)){
            (row, data, cell) in
            cell.bind(with: data, type: .grid)
        }.disposed(by: disposeBag)
        
        postCollectionView.rx.modelSelected(PostList.self)
            .asDriver()
            .drive(with: self, onNext: { owner, post in
                owner.viewModel.pushToPostDetail(model: post)
            }).disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperMainLogo.image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: .none)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperProfileLogo.image.downSample(size: .init(width: 36, height: 36)).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(profileButtonDidTap))
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    override func addView() {
        view.addSubViews(mainLabel,
                         rocketImageView,
                         makeFeedButton,
                         hotCategory,
                         hotCollectionView,
                         postCategory,
                         segmentedControl,
                         postCollectionView,
                         profileImage)
    }
    
    override func setLayout() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.equalTo(12)
            make.width.equalTo(190)
        }
        
        rocketImageView.snp.makeConstraints { make in
            make.centerY.equalTo(mainLabel)
            make.left.equalTo(mainLabel.snp.right).offset(20)
            make.width.equalTo(140)
            make.height.equalTo(160)
        }
        
        makeFeedButton.snp.makeConstraints { make in
            make.left.equalTo(mainLabel)
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
        }
        
        hotCategory.snp.makeConstraints { make in
            make.top.equalTo(makeFeedButton.snp.bottom).offset(72)
            make.left.equalTo(makeFeedButton)
            make.height.equalTo(32)
        }
        
        hotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hotCategory.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(360)
        }
        
        postCategory.snp.makeConstraints { make in
            make.top.equalTo(hotCollectionView.snp.bottom).offset(90)
            make.left.equalTo(hotCategory)
            make.size.equalTo(hotCategory)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.centerY.equalTo(postCategory)
            make.right.equalTo(postCategory)
        }
        
        postCollectionView.snp.makeConstraints { make in
            make.top.equalTo(postCategory.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func profileButtonDidTap(){
        
    }
    
    @objc func makeFeedButtonDidTap(){
        viewModel.pushToMakeFeedVC()
    }
}
