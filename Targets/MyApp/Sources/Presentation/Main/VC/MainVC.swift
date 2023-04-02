import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class MainVC: BaseVC<MainVM>,UITextViewDelegate,UIScrollViewDelegate{
    
    var model: DetailResponse!
    private let scrollView = UIScrollView().then{
        $0.backgroundColor = .clear
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .clear
    }
    
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
        $0.isScrollEnabled = false
    }
    
    private let postCategory = UITextView().then{
        $0.backgroundColor = GlogAsset.Colors.paperBlankColor.color
        $0.layer.cornerRadius = 10
        $0.text = "💻 게시물’s"
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        $0.isSelectable = false
        $0.isEditable = false
    }
    
    private var hotCollectionView: UICollectionView!
    
    private let searchBar = UISearchBar().then{
        $0.searchTextField.backgroundColor = GlogAsset.Colors.paperBlankColor.color
        $0.barTintColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.searchTextField.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.searchTextField.leftView?.tintColor = GlogAsset.Colors.paperGrayColor.color
        $0.searchBarStyle = .minimal
    }
    private var postCollectionView: UICollectionView!
    
    private let segmentedControl = UISegmentedControl(items: [UIImage(systemName: "circle.grid.2x2.fill") ?? "", UIImage(systemName: "line.3.horizontal") ?? "", UIImage(systemName: "square.fill") ?? ""]).then{
        $0.selectedSegmentTintColor = GlogAsset.Colors.paperStartColor.color
        $0.selectedSegmentIndex = 2
        $0.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setup() {
        DispatchQueue.main.async {
            self.gifImage.animate(withGIFNamed: "Paper_Smile", animationBlock: {})
        }
        setCollectionView()
        setPostCollectionView()
        
        viewModel.fetchHotPostList { _ in
            self.hotCollectionView.reloadData()
        }
        
        viewModel.fetchPostList(completion: { _ in
            self.postCollectionView.reloadData()
        }, search: searchBar.text!)
        
        makeFeedButton.createGradient()
    }
    
    private func hotLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(5.0),
            heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize).then{
            $0.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12)
        }
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(3.5),
            heightDimension: .fractionalWidth(2.9/3))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullPhotoItem,
            count: 4)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setCollectionView(){
        hotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: hotLayout())
        hotCollectionView?.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        hotCollectionView?.delegate = self
        hotCollectionView?.dataSource = self
        hotCollectionView?.showsHorizontalScrollIndicator = false
        hotCollectionView?.register(HotCollectionViewCell.self, forCellWithReuseIdentifier: HotCollectionViewCell.identifier)
        self.hotCollectionView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setPostCollectionView(){
        postCollectionView = UICollectionView(frame: .zero, collectionViewLayout: postListLayout(type: .post))
        postCollectionView?.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        postCollectionView?.delegate = self
        postCollectionView?.dataSource = self
        postCollectionView?.showsHorizontalScrollIndicator = false
        postCollectionView?.register(PostListCollectionViewCell.self, forCellWithReuseIdentifier: PostListCollectionViewCell.identifier)
        postCollectionView.isScrollEnabled = false
        postCollectionView.backgroundColor = .clear
        self.postCollectionView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperMainLogo.image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: .none)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperProfileLogo.image.downSample(size: .init(width: 36, height: 36)).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: .none)
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [mainLabel,
         gifImage,
         makeFeedButton,
         hotCategory,
         hotCollectionView,
         postCategory,
         searchBar,
         segmentedControl,
         postCollectionView
        ].forEach{
            contentView.addSubview($0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.postCollectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.postCollectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    deinit {
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let cv = object as? UICollectionView, cv == postCollectionView {
                if let newValue = change?[.newKey] as? CGSize {
                    postCollectionView.snp.updateConstraints {
                        $0.height.equalTo(newValue.height)
                    }
                    let oldValue = change?[.oldKey] as? CGSize ?? .init(width: 0, height: 0)
                    print(newValue, oldValue, scrollView.contentSize, scrollView.contentSize.height - oldValue.height + newValue.height)
                    scrollView.contentSize = .init(width: scrollView.contentSize.width, height: scrollView.contentSize.height - oldValue.height * newValue.height)
                }
            }
        }
    }
    
    private func postListLayout(type: SortButtonType) -> UICollectionViewLayout{
        switch type {
        case .grid:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(3.5),
                heightDimension: .fractionalHeight(2.9/3))
            let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize).then{
                $0.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 6, trailing: 6)
            }
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1.5/3))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: fullPhotoItem,
                count: 2)
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
            
        case .table:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(2.9/3))
            let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize).then{
                $0.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
            }
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(3/3),
                heightDimension: .fractionalWidth(0.3))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: fullPhotoItem,
                count: 1)
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
            
        case .post:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(3.5),
                heightDimension: .fractionalHeight(2.9/3))
            let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize).then{
                $0.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
            }
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2.9/3))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: fullPhotoItem,
                count: 1)
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
        return .init()
    }
    
    override func setLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.centerX.width.top.bottom.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
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
            make.right.equalTo(makeFeedButton)
        }
        
        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(5)
            make.top.equalTo(postCategory.snp.bottom).offset(16)
        }
        
        postCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(view.frame.size.height * 1.3)
            make.bottom.equalToSuperview().inset(3)
        }
    }
    
    @objc func profileButtonDidTap(){
        
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) -> UICollectionViewLayout{
        if sender.selectedSegmentIndex == 0 {
            print("grid")
            return postListLayout(type: .grid)
        } else if sender.selectedSegmentIndex == 1{
            print("table")
        } else if sender.selectedSegmentIndex == 2{
            print("post")
        }
        else{
            return postListLayout(type: .grid)
        }
        return .init()
    }
}

extension MainVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.hotCollectionView{
            return viewModel.hotFeed.count
        } else {
            return viewModel.postList.count
        }
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.hotCollectionView{
            let hotCell = hotCollectionView.dequeueReusableCell(withReuseIdentifier: HotCollectionViewCell.identifier, for: indexPath) as! HotCollectionViewCell
            hotCell.bind(with: viewModel.hotFeed[indexPath.row])
            return hotCell
        }
        else {
            let postCell = postCollectionView.dequeueReusableCell(withReuseIdentifier: PostListCollectionViewCell.identifier, for: indexPath) as! PostListCollectionViewCell
            postCell.bind(with: viewModel.postList[indexPath.row], type: .post)
            return postCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.hotCollectionView{
            viewModel.detailPost(completion: { _ in
                self.viewModel.pushToDetailVC(model: self.viewModel.detailPost)
            }, id: viewModel.hotFeed[indexPath.item].id)
        }
        else {
            viewModel.detailPost(completion: { _ in
                self.viewModel.pushToDetailVC(model: self.viewModel.detailPost)
            }, id: viewModel.postList[indexPath.item].id)
        }
    }
}
