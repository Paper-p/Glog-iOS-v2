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
    
    private var tagCollectionView: UICollectionView!
    
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
    
    override func setup() {
        setCollectionView()
    }
    
    private func tagLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(10.0),
            heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize).then{
            $0.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12)
        }
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.3),
            heightDimension: .fractionalWidth(0.08))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullPhotoItem,
            count: 4)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setCollectionView(){
        tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: tagLayout())
        tagCollectionView?.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        tagCollectionView?.delegate = self
        tagCollectionView?.dataSource = self
        tagCollectionView?.showsHorizontalScrollIndicator = false
        tagCollectionView?.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        self.tagCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        tagCollectionView.backgroundColor = .red
    }
    
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod(_:)))
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(titleLabel,tagCollectionView)
    }
    
    override func setLayout() {
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.width.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(33)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(56)
        }
    }
    
    private func bindData(with model: DetailResponse){
        titleLabel.text = model.title
        profileImageView.kf.setImage(with: URL(string: model.thumbnail ?? ""))
    }
    
    @objc func tapMethod(_ sender: UITapGestureRecognizer) {
       self.view.endEditing(true)
   }
       
}

extension DetailVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (model?.tagList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagCell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
        tagCell.tagLabel.text = model?.tagList[indexPath.item]
        return tagCell
    }
}
