
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import Kingfisher

final class PostListCollectionViewCell: BaseCollectionViewCell{
    static let identifier = "PostListCollectionViewCell"
    
    private let thumbnailImageView = UIImageView(image: UIImage(named: "Paper_Background")).then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.textAlignment = .left
        $0.sizeToFit()
    }
    
    private let contentLabel = UILabel().then{
        $0.textColor = UIColor(red: 0.483, green: 0.483, blue: 0.483, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.backgroundColor = .clear
        $0.sizeToFit()
    }
    
    private let likeButton = UIButton().then{
        $0.setTitleColor(UIColor(red: 0.483, green: 0.483, blue: 0.483, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.setImage(UIImage(named: "Paper_LikeLogo"), for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -10)
    }
    
    private let hitButton = UIButton().then{
        $0.setTitleColor(UIColor(red: 0.483, green: 0.483, blue: 0.483, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.setImage(UIImage(named: "Paper_HitLogo")?.downSample(size: .init(width: 16, height: 16)).withRenderingMode(.alwaysOriginal), for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addView(){
        contentView.addSubViews(thumbnailImageView, titleLabel, contentLabel, likeButton, hitButton)
    }
    
    override func setLayout(){
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(208)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(32)
            make.width.equalTo(thumbnailImageView)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.width.equalTo(titleLabel)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(30)
            make.left.equalTo(contentLabel).offset(32)
        }
        
        hitButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.left.equalTo(likeButton.snp.right).offset(32)
        }
    }
    
    func bind(with model: PostList){
        DispatchQueue.main.async { [self] in
            self.thumbnailImageView.kf.setImage(with: URL(string: model.thumbnail ?? ""))
            self.titleLabel.text = model.title
            self.contentLabel.text = model.previewContent.filter { !"# \n - 1.".contains($0) }
            self.likeButton.setTitle("\(model.likeCount)", for: .normal)
            self.hitButton.setTitle("\(model.hit)", for: .normal)
            if model.isLiked {
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.downSample(size: .init(width: 16, height: 12)).tintColor(GlogAsset.Colors.paperStartColor.color).withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.downSample(size: .init(width: 26, height: 22)).tintColor(GlogAsset.Colors.paperGrayColor.color).withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
}
