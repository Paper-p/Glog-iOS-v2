
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import Kingfisher

final class HotCollectionViewCell: BaseCollectionViewCell{
    static let identifier = "HotCollectionViewCell"
    
    private let thumbnailImageView = UIImageView(image: UIImage(named: "Paper_Background")).then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
        $0.contentMode = .scaleAspectFill
    }
    
    private let itemView = UIView().then{
        $0.layer.cornerRadius = 10
    }
    
    private let titleLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    private let contentTextView = UITextView().then{
        $0.textColor = UIColor(red: 0.483, green: 0.483, blue: 0.483, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.backgroundColor = .clear
        $0.isSelectable = false
        $0.isEditable = false
        $0.isScrollEnabled = false
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
        setBlur()
    }
    
    private func setBlur(){
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = CGRect(x: 0, y: 0, width: 311, height: 145)
        visualEffectView.layer.cornerRadius = 10
        visualEffectView.clipsToBounds = true
        itemView.addSubViews(visualEffectView,titleLabel,contentTextView,likeButton,hitButton)
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(10)
            make.width.equalToSuperview().inset(10)
            make.height.equalTo(24)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.width.equalTo(titleLabel)
            make.height.equalTo(67)
        }
        
        likeButton.snp.makeConstraints { make in
            make.left.equalTo(contentTextView)
            make.bottom.equalToSuperview().inset(9)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        hitButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.left.equalTo(likeButton.snp.right)
            make.size.equalTo(likeButton)
        }
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addView(){
        contentView.addSubViews(thumbnailImageView,itemView)
    }
    
    override func setLayout(){
        thumbnailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        itemView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(145)
        }
    }
    
    func bind(with model: HotPostList){
        DispatchQueue.main.async { [self] in
            self.thumbnailImageView.kf.setImage(with: URL(string: model.thumbnail))
            self.titleLabel.text = model.title
            self.contentTextView.text = model.previewContent.filter { !"# \n - 1.".contains($0) }
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
