
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
    }
    
    private let itemView = UIView().then{
        $0.layer.cornerRadius = 10
    }
    
    private let titleLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    private let contentLabel = UILabel().then{
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private let likeButton = UIButton().then{
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    private let hitButton = UIButton().then{
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBlur()
    }
    
    private func setBlur(){
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = CGRect(x: 0, y: 0, width: 325, height: 145)
        visualEffectView.layer.cornerRadius = 10
        visualEffectView.clipsToBounds = true
        itemView.addSubview(visualEffectView)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addView(){
        contentView.addSubViews(thumbnailImageView,itemView,titleLabel,contentLabel,likeButton,hitButton)
    }
    
    override func setLayout(){
        thumbnailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        itemView.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(145)
        }
    }
    
    func bind(with model: HotResponse){
        DispatchQueue.main.async { [self] in
            self.thumbnailImageView.kf.setImage(with: URL(string: model.thumbnail))
            print("\(model.thumbnail)sdlfkgjsl;dkfjgsl;dfjgs;lkdjfg;skdlf")
            self.titleLabel.text = model.title
            self.contentLabel.text = model.previewContent
            self.likeButton.setTitle("\(model.likeCount)", for: .normal)
            self.hitButton.setTitle("\(model.hit)", for: .normal)
            if model.isLiked {
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.tintColor(GlogAsset.Colors.paperStartColor.color), for: .normal)
            } else {
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.tintColor(GlogAsset.Colors.paperGrayColor.color), for: .normal)
            }
        }
    }
}
