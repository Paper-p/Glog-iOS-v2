
import UIKit
import SnapKit
import Then
import Kingfisher

final class HotCollectionViewCell: UICollectionViewCell{
    static let identifier = "HotCollectionViewCell"
    
    private let thumbnailImageView = UIImageView().then{
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
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        contentView.addSubViews(thumbnailImageView,itemView,titleLabel,contentLabel,likeButton,hitButton)
    }
    
    private func setLayout(){
        thumbnailImageView.snp.makeConstraints { make in
            make.width.equalTo(324)
            make.height.equalTo(429)
            make.leftMargin.equalTo(12)
        }
    }
    
    func bindingData(with data: HotResponse){
        DispatchQueue.main.async { [self] in
            if let imgUrl = URL(string: data.thumbnail){
                self.thumbnailImageView.kf.setImage(with: imgUrl)
            }
            self.titleLabel.text = data.title
            self.contentLabel.text = data.previewContent
            self.likeButton.setTitle("\(data.likeCount)", for: .normal)
            self.hitButton.setTitle("\(data.hit)", for: .normal)
            if data.isLiked {
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.tintColor(GlogAsset.Colors.paperStartColor.color), for: .normal)
            } else {
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.tintColor(GlogAsset.Colors.paperGrayColor.color), for: .normal)
            }
        }
    }
}
