import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class MainVC: BaseVC<MainVM>,UITextViewDelegate{
    
    private let mainLabel = UILabel().then{
        $0.text = "너의 생각을 글로 표현해봐!"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private let gifImage = GIFImageView()
    
    private let makeFeedButton = GlogButton(title: "게시글 작성하러 가기")
    
    private let hotCategory = UITextView().then{
        $0.backgroundColor = GlogAsset.Colors.paperBlankColor.color
        $0.layer.cornerRadius = 10
        $0.text = "🔥HOT’"
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.isSelectable = false
        $0.isEditable = false
    }
    
    private var hotCollectionView: UICollectionView!
    private var layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 12
    }
    
    private let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setup() {
        DispatchQueue.main.async {
            self.gifImage.animate(withGIFNamed: "Paper_Smile", animationBlock: {})
        }
        
        setCollectionView()
        viewModel.fetchHotPostList { _ in
            self.hotCollectionView.reloadData()
        }
        
        viewModel.fetchPostList(completion: { _ in
            //리로딩.
        }, search: searchBar.text!)
        
        makeFeedButton.createGradient()
    }
    
    override func addView() {
        [mainLabel,
         gifImage,
         makeFeedButton,
         hotCategory,
         hotCollectionView
        ].forEach{
            view.addSubview($0)
        }
    }
    
    private func setCollectionView(){
        hotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        hotCollectionView?.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        hotCollectionView?.delegate = self
        hotCollectionView?.dataSource = self
        hotCollectionView?.showsHorizontalScrollIndicator = false
        hotCollectionView?.register(HotCollectionViewCell.self, forCellWithReuseIdentifier: HotCollectionViewCell.identifier)
        self.hotCollectionView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperMainLogo.image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: .none)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperProfileLogo.image.downSample(size: .init(width: 36, height: 36)).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: .none)
    }
    
    override func setLayout() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(123)
            make.left.equalTo(12)
            make.width.equalTo(230)
            make.height.equalTo(98)
        }
        
        gifImage.snp.makeConstraints { make in
            make.centerY.equalTo(mainLabel)
            make.right.equalTo(12)
            make.height.equalTo(135)
            make.width.equalTo(165)
        }
        
        makeFeedButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(28)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        
        hotCategory.snp.makeConstraints { make in
            make.top.equalTo(makeFeedButton.snp.bottom).offset(72)
            make.left.equalTo(makeFeedButton)
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
        hotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hotCategory.snp.bottom).offset(16)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.bottom.equalTo(-30)
        }
    }
    
    @objc func profileButtonDidTap(){
        
    }
}

extension MainVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 325, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hotFeed.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hotCollectionView.dequeueReusableCell(withReuseIdentifier: HotCollectionViewCell.identifier, for: indexPath) as! HotCollectionViewCell
        cell.bind(with: viewModel.hotFeed[indexPath.row])
        cell.selectedBackgroundView = .none
        return cell
    }
}
