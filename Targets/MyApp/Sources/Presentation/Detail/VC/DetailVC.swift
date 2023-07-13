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
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
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
        $0.isScrollEnabled = true
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.detailPost(id: viewModel.id) { _ in
            DispatchQueue.main.async{
                self.bindVM()
                self.tagCollectionView.reloadData()
            }
        }
    }
    
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

    
    override func setup() {
        tagCollectionView.collectionViewLayout = createTagLayout()
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    }
    
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews(thumbnailImageView, tagCollectionView, contentText, viewCountLabel)
        thumbnailImageView.addSubViews(titleLabel,dateLabel,authorLabel)
    }
    
    override func setLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.centerX.bottom.top.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalTo(115)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.left.equalTo(dateLabel.snp.right).offset(7)
            make.centerY.equalTo(dateLabel)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        contentText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tagCollectionView.snp.bottom)
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
            
            self.thumbnailImageView.kf.setImage(with: URL(string: self.viewModel.detailData?.thumbnail ?? ""))
            self.titleLabel.text = self.viewModel.detailData?.title
            self.dateLabel.text = self.viewModel.detailData?.createdAt.toGlogDateString()
            self.authorLabel.text = self.viewModel.detailData?.author.nickname
            self.contentText.text = attributedString.string
            self.viewCountLabel.text = "조회수 \(self.viewModel.detailData?.hit ?? .init())"
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
