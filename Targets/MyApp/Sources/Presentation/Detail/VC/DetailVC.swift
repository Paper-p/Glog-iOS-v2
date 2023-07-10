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
    }
    
    private let tagLayout = UICollectionViewFlowLayout().then {
        $0.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        $0.scrollDirection = .horizontal
    }
    
    private let contentText = UITextView().then{
        $0.textColor = .white
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
        view.addSubViews(thumbnailImageView, tagCollectionView, contentText)
        thumbnailImageView.addSubViews(titleLabel,dateLabel,authorLabel)
    }
    
    override func setLayout() {
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
            make.top.equalTo(tagCollectionView)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override func bindVM() {
        DispatchQueue.main.async {
            self.thumbnailImageView.kf.setImage(with: URL(string: self.viewModel.detailData?.thumbnail ?? ""))
            self.titleLabel.text = self.viewModel.detailData?.title
            self.dateLabel.text = self.viewModel.detailData?.createdAt.toGlogDateString()
            self.authorLabel.text = self.viewModel.detailData?.author.nickname
            self.contentText.text = self.viewModel.detailData?.content
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
