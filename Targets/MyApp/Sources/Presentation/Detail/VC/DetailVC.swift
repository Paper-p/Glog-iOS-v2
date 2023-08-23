import Then
import Markdownosaur
import Markdown
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class DetailVC: BaseVC<DetailVM>{
    
    enum ContentSizeKey {
        static let key = "contentSize"
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private lazy var optionItem = [
        UIAction(title: "게시물 수정", handler: { _ in self.modifyButtonDidTap() }),
        UIAction(title: "게시물 삭제", attributes: .destructive, handler: { _ in self.deleteButtonDidTap()}),
    ]
    
    private lazy var optionButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis")?.tintColor(UIColor.white)).then {
        $0.menu = UIMenu(children: optionItem)
        $0.tintColor = .black
    }
    
    private let thumbnailImageView = UIImageView()
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        $0.textColor = UIColor.white
        $0.sizeToFit()
    }
    
    private let dateLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = UIColor.gray
        $0.sizeToFit()
    }
    
    private let authorLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = UIColor.white
        $0.sizeToFit()
    }
    
    private let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init()).then{
        $0.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        $0.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.isScrollEnabled = false
    }
    
    private let commentTableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 70
        $0.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
    }
    
    private let tagLayout = UICollectionViewFlowLayout().then {
        $0.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        $0.scrollDirection = .horizontal
    }
    
    private let contentText = UITextView().then{
        $0.textColor = .white
        $0.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.isSelectable = false
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.translatesAutoresizingMaskIntoConstraints = true
    }
    
    private let viewCountLabel = UILabel().then{
        $0.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.textColor = GlogAsset.Colors.paperStartColor.color
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.sizeToFit()
    }
    
    private let profileImageView = UIImageView()
    
    private let likeButton = UIButton().then{
        $0.setImage(UIImage(named: "Paper_LikeLogo"), for: .normal)
    }
    
    private let hitButton = UIButton().then{
        $0.setImage(UIImage(named: "Paper_HitLogo"), for: .normal)
    }
    
    private let commentTextView = UITextView().then{
        $0.text = "댓글을 달아보세요."
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.layer.cornerRadius = 10
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.layer.backgroundColor = GlogAsset.Colors.paperBlankColor.color.cgColor
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 28, bottom: 40, right: 75)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        viewModel.detailPost(id: viewModel.id) { _ in
            DispatchQueue.main.async{
                self.bindVM()
                self.tagCollectionView.reloadData()
            }
        }
    }
    
    override func configureNavigation() {
        self.navigationItem.rightBarButtonItem = optionButton
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(tapMethod(_:)))
    
    private func createTagLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
           widthDimension: .estimated(60),
           heightDimension: .absolute(28)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
           heightDimension: .absolute(55)
        )

        let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitems: [item]
        )
        group.interItemSpacing = .fixed(8)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 76, trailing: 16)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        return layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.commentTableView.addObserver(self, forKeyPath: ContentSizeKey.key, options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.commentTableView.removeObserver(self, forKeyPath: ContentSizeKey.key)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == ContentSizeKey.key {
            if object is UITableView {
                if let newValue = change?[.newKey] as? CGSize {
                    commentTableView.snp.updateConstraints {
                        $0.height.equalTo(newValue.height + 50)
                    }
                }
            }
        }
    }

    
    override func setup() {
        tagCollectionView.collectionViewLayout = createTagLayout()
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    }
    
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews(thumbnailImageView,
                                tagCollectionView,
                                contentText,
                                viewCountLabel,
                                profileImageView,
                                titleLabel,
                                dateLabel,
                                authorLabel,
                                likeButton,
                                hitButton
        )
    }
    
    override func setLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.top.equalToSuperview()
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(tagCollectionView.snp.bottom)
            make.left.equalToSuperview().inset(12)
            make.size.equalTo(35)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(profileImageView.snp.bottom).offset(25)
            make.height.equalTo(350)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.top.equalTo(profileImageView.snp.top)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.left.equalTo(dateLabel)
        }
        
        hitButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(profileImageView)
        }
        
        likeButton.snp.makeConstraints { make in
            make.right.equalTo(hitButton.snp.left).offset(7)
            make.centerY.equalTo(hitButton)
        }
        
        contentText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(thumbnailImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        viewCountLabel.snp.makeConstraints { make in
            make.top.equalTo(contentText.snp.bottom).offset(65)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
    }
    
    override func bindVM() {
        DispatchQueue.main.async {
            
            let source = self.viewModel.detailData?.content
            let document = Document(parsing: source ?? .init())
            var markdownsaur = Markdownosaur()
            let attributedString = markdownsaur.attributedString(from: document)
            
            self.profileImageView.kf.setImage(with: URL(string: self.viewModel.detailData?.author.profileImageUrl ?? .init()), options: [.processor(SVGImgProcessor())])
            self.hitButton.setTitle(self.viewModel.detailData?.hit.description, for: .normal)
            self.likeButton.setTitle(self.viewModel.detailData?.likeCount.description, for: .normal)
            self.thumbnailImageView.kf.setImage(with: URL(string: self.viewModel.detailData?.thumbnail ?? .init()))
            self.titleLabel.text = self.viewModel.detailData?.title
            self.dateLabel.text = self.viewModel.detailData?.createdAt.toGlogDateString()
            self.authorLabel.text = self.viewModel.detailData?.author.nickname
            self.contentText.text = attributedString.string
            self.viewCountLabel.text = "조회수 \(self.viewModel.detailData?.hit ?? .init())"
        }
    }
    
    @objc private func tapMethod(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func modifyButtonDidTap(){
        
    }
    
    @objc func deleteButtonDidTap(){
        viewModel.deleteFeed(id: viewModel.id) { _ in
            self.viewModel.pushToMain()
        }
    }
}

extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.detailData?.tagList.count ?? .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
        cell.bind(with: viewModel.detailData!)
        return cell
    }
}
