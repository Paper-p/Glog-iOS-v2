import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class MyPageVC: BaseVC<MyPageVM>{
    var model: UserProfileResponse!
    private let profileImageView = UIImageView(image: UIImage(systemName: "person.crop.circle")).then{
        $0.layer.cornerRadius = 18
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
        $0.contentMode = .scaleAspectFit
    }
    
    private let nicknameLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
    }
    
    private let postCategory = UIView()
    
    private var postListCollectionView: UICollectionView!
    
    override func setup() {
        setPostCollectionView()
    }
    
    private func setPostCollectionView(){
        postListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        postListCollectionView?.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        postListCollectionView?.delegate = self
        postListCollectionView?.dataSource = self
        postListCollectionView?.showsHorizontalScrollIndicator = false
        postListCollectionView?.register(PostListCollectionViewCell.self, forCellWithReuseIdentifier: PostListCollectionViewCell.identifier)
        postListCollectionView.isScrollEnabled = false
        postListCollectionView.backgroundColor = .clear
        self.postListCollectionView?.translatesAutoresizingMaskIntoConstraints = false
    }

    
    init(viewModel: MyPageVM, model: UserProfileResponse) {
        super.init(viewModel)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postListCollectionView.dequeueReusableCell(withReuseIdentifier: MyPostListCell.identifier, for: indexPath) as! MyPostListCell
        cell.bind(with: model!.feedList[indexPath.row])
        cell.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        return cell
    }
}
