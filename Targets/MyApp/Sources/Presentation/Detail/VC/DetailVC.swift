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
    
    private let profileImageView = UIImageView(image: UIImage(systemName: "person.crop.circle")).then{
        $0.layer.cornerRadius = 17
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
        $0.contentMode = .scaleToFill
        $0.layer.masksToBounds = true
    }
    
    private let authorLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        $0.textAlignment = .left
        $0.sizeToFit()
    }
    private let createdAtLabel = UILabel().then{
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.textAlignment = .left
    }
    private let likeButton = UIButton().then{
        $0.setTitleColor(UIColor(red: 0.483, green: 0.483, blue: 0.483, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.setImage(UIImage(named: "Paper_LikeLogo"), for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        $0.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
    }
    
    private let hitButton = UIButton().then{
        $0.setTitleColor(UIColor(red: 0.483, green: 0.483, blue: 0.483, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.setImage(UIImage(named: "Paper_HitLogo")?.downSample(size: .init(width: 16, height: 16)).withRenderingMode(.alwaysOriginal), for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: -1)
    }
    
    private let thumbnailImageView = UIImageView(image: UIImage(named: "Paper_Background")).then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
        $0.sizeToFit()
        $0.contentMode = .scaleToFill
    }
    
    private let contentTextView = UITextView().then{
        $0.textColor = .white
        $0.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.isSelectable = false
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.translatesAutoresizingMaskIntoConstraints = true
    }
    
    private let commentCategory = UITextView().then{
        $0.backgroundColor = GlogAsset.Colors.paperBlankColor.color
        $0.layer.cornerRadius = 10
        $0.text = "📖 댓글"
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.isSelectable = false
        $0.isEditable = false
        $0.isScrollEnabled = false
    }
    
    private let commentTextView = UITextView().then{
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.layer.cornerRadius = 10
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.layer.backgroundColor = GlogAsset.Colors.paperBlankColor.color.cgColor
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 28, bottom: 40, right: 75)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.isScrollEnabled = false
        
    }
    
    private let registerButton = GlogButton(title: "등록",width: 63, height: 29).then{
        $0.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
    }
    
    private var commentTableView: UITableView!
    
    override func configureNavigation() {
        self.navigationItem.titleView = UIImageView(image: GlogAsset.Images.paperMainLogo.image.downSample(size: .init(width: 26, height: 26)).withRenderingMode(.alwaysOriginal))
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(postAlertButtinDidTap(_:)))
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
        setTableView()
        registerButton.createGradient()
        //commentTextView.delegate = self
        registerButtonDidTap()
    }
    
    private func tagLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(60),
            heightDimension: .absolute(30)
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

        let section = NSCollectionLayoutSection(group: group).then{
            $0.interGroupSpacing = 12
            $0.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        }

        let config = UICollectionViewCompositionalLayoutConfiguration().then{
            $0.scrollDirection = .vertical
        }
        let layout = UICollectionViewCompositionalLayout(section: section).then{
            $0.configuration = config
        }
        
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
    }
    
    private func setTableView(){
        commentTableView = UITableView(frame: .zero)
        commentTableView?.rowHeight = UITableView.automaticDimension
        commentTableView?.estimatedRowHeight = 84
        commentTableView?.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        commentTableView?.delegate = self
        commentTableView?.dataSource = self
        commentTableView.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
    }
    
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod(_:)))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.commentTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        viewModel.detailPost(id: model!.id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.commentTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey] as? CGSize {
                    commentTableView.snp.updateConstraints {
                        $0.height.equalTo(newValue.height + 50)
                    }
                }
            }
        }
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(titleLabel,tagCollectionView,profileImageView,authorLabel,createdAtLabel,likeButton,hitButton,thumbnailImageView,contentTextView, commentCategory, commentTextView, commentTableView)
        commentTextView.addSubview(registerButton)
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
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(tagCollectionView.snp.bottom)
            make.left.equalToSuperview().inset(12)
            make.size.equalTo(36)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.top.equalTo(profileImageView.snp.top)
            make.height.equalTo(19)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.left.equalTo(authorLabel)
            make.top.equalTo(authorLabel.snp.bottom).offset(1)
            make.width.equalTo(150)
            make.height.equalTo(16)
        }
        
        hitButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.top.equalTo(tagCollectionView.snp.bottom)
            make.width.equalTo(55)
            make.height.equalTo(25)
        }
        
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(hitButton)
            make.right.equalTo(hitButton.snp.left)
            make.centerY.equalTo(hitButton)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(view.bounds.height * 0.2)
            make.centerX.equalToSuperview()
        }
        
        contentTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        commentCategory.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(10)
            make.left.equalTo(contentTextView)
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(commentCategory.snp.bottom).offset(16)
            make.left.equalTo(commentCategory)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(97)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.left.equalToSuperview().offset(295)
            make.width.equalTo(63)
            make.height.equalTo(28)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(commentTextView.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.commentTextView.resignFirstResponder()
    }
    
    private func bindData(with model: DetailResponse){
        titleLabel.text = model.title
        DispatchQueue.main.async {
            if let image = URL(string: model.author.profileImageUrl){
                self.profileImageView.kf.setImage(with: image)
            }
        }
        authorLabel.text = model.author.nickname
        createdAtLabel.text = model.createdAt.toGlogDateString()
        likeButton.setTitle("\(model.likeCount)", for: .normal)
        hitButton.setTitle("\(model.hit)", for: .normal)
        if model.isLiked {
            likeButton.setImage(.init(named: "Paper_LikeLogo")?.downSample(size: .init(width: 16, height: 12)).tintColor(GlogAsset.Colors.paperStartColor.color).withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            likeButton.setImage(.init(named: "Paper_LikeLogo")?.downSample(size: .init(width: 26, height: 22)).tintColor(GlogAsset.Colors.paperGrayColor.color).withRenderingMode(.alwaysOriginal), for: .normal)
        }
        thumbnailImageView.kf.setImage(with: URL(string: model.thumbnail!))
        contentTextView.text = model.content
        
        if model.isMine{
            self.navigationItem.rightBarButtonItem?.isHidden = false
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
        let document = Document(parsing: contentTextView.text)
        var markdownsaur = Markdownosaur()
        let markdownString = markdownsaur.attributedString(from: document)
        contentTextView.attributedText = markdownString
        contentTextView.textColor = .white
    }
    
    @objc func tapMethod(_ sender: UITapGestureRecognizer) {
       self.view.endEditing(true)
    }
    
    @objc func likeButtonDidTap(){
        print("like button tap")
        
        if model!.isLiked == true {
            viewModel.fetchCancelLike(id: model!.id) { _ in
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.downSample(size: .init(width: 26, height: 22)).tintColor(GlogAsset.Colors.paperGrayColor.color).withRenderingMode(.alwaysOriginal), for: .normal)
                self.model!.isLiked = false
            }
        } else {
            viewModel.fetchLike(id: model!.id) { _ in
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.downSample(size: .init(width: 16, height: 12)).tintColor(GlogAsset.Colors.paperStartColor.color).withRenderingMode(.alwaysOriginal), for: .normal)
                self.model!.isLiked = true
            }
        }
    }
    
    @objc func registerButtonDidTap(){
        print("button Tap")
        if commentTextView.text.isEmpty == false {
            viewModel.addComment(id: model?.id ?? .init(), content: commentTextView.text) {
                DispatchQueue.main.async {
                    self.commentTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                }
            }
        }
    }
    
    @objc func postAlertButtinDidTap(_ sender: Any){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAlert = UIAlertAction(title: "수정", style: .default) { _ in
            
        }
        let deleteAlert = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.viewModel.deleteFeed(id: self.model!.id) { _ in
                self.viewModel.pushToMain()
            }
        }
        let cancelAlert = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(editAlert)
        alert.addAction(deleteAlert)
        alert.addAction(cancelAlert)
        
        self.present(alert, animated: true)
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


extension DetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.comments.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        cell.bindComment(model: (model?.comments[indexPath.row])!)
        cell.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}
