import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class MyPageVC: BaseVC<MyPageVM>{
    var model: UserProfileResponse?
    
    private let scrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let profileImageView = UIImageView(image: UIImage(systemName: "person.crop.circle")).then{
        $0.layer.cornerRadius = 50
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
        $0.contentMode = .scaleToFill
        $0.layer.masksToBounds = true
    }
    
    private let nicknameLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let editButton = GlogButton(title: "프로필 수정", width: 366, height: 40)
    
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
    
    private var myPostCollectionView: UICollectionView!
    
    private let noPostLabel = UILabel().then{
        $0.text = "👊\n아직 게시물이 없어요"
        $0.numberOfLines = 2
        $0.textColor = .white
        $0.sizeToFit()
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    private func setPostTableView(){
        myPostCollectionView = UICollectionView(frame: .zero, collectionViewLayout: postListLayout())
        myPostCollectionView?.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        myPostCollectionView?.delegate = self
        myPostCollectionView?.dataSource = self
        myPostCollectionView?.showsHorizontalScrollIndicator = false
        myPostCollectionView?.register(MyPostListCell.self, forCellWithReuseIdentifier: MyPostListCell.identifier)
        myPostCollectionView.isScrollEnabled = false
        myPostCollectionView.backgroundColor = .clear
        self.myPostCollectionView?.translatesAutoresizingMaskIntoConstraints = false
    }

    
    init(viewModel: MyPageVM, model: UserProfileResponse) {
        super.init(viewModel)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureNavigation() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData(with: model!)
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        checkFeedList()
    }
    
    override func setup() {
        setPostTableView()
        editButton.createGradient()
    }
    
    private func postListLayout() -> UICollectionViewLayout{
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
    }
    
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod(_:)))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myPostCollectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.myPostCollectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UICollectionView {
                if let newValue = change?[.newKey] as? CGSize {
                    myPostCollectionView.snp.updateConstraints {
                        $0.height.equalTo(newValue.height + 50)
                    }
                }
            }
        }
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(profileImageView, nicknameLabel,editButton, postCategory, myPostCollectionView)
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.width.top.bottom.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.size.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(17)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nicknameLabel.snp.bottom).offset(40)
            make.width.equalToSuperview().inset(12)
        }
        
        postCategory.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(12)
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
        
        myPostCollectionView.snp.makeConstraints { make in
            make.top.equalTo(postCategory.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func checkFeedList(){
        if model?.feedList.isEmpty == true{
            contentView.addSubview(noPostLabel)
            noPostLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(postCategory.snp.bottom).offset(40)
            }
        }
    }
    
    private func bindData(with model: UserProfileResponse){
        nicknameLabel.text = model.nickname
        DispatchQueue.main.async {
            if let image = URL(string: model.profileImageUrl){
                self.profileImageView.kf.setImage(with: image)
            }
        }
    }
    
    @objc func tapMethod(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension MyPageVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (model?.feedList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myPostCollectionView.dequeueReusableCell(withReuseIdentifier: MyPostListCell.identifier, for: indexPath) as! MyPostListCell
        cell.bindPost(with: (model?.feedList[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("asdfkljasdhflak")
        viewModel.detailPost(completion: { _ in
            self.viewModel.pushToDetailVC(model: self.viewModel.detailPost)
        }, id: (model?.feedList[indexPath.item].id)!)
    }
}