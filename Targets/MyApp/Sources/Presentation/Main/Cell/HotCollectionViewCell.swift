
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import Kingfisher

class HotCollectionViewCell: UICollectionViewCell{
    static let identifier = "HotCollectionViewCell"
    
    let thumbnailImageView = UIImageView().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
    }
    
    let itemView = UIView().then{
        $0.layer.cornerRadius = 10
    }
    
    let titleLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    let contentLabel = UILabel().then{
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    let likeButton = UIButton().then{
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    let hitButton = UIButton().then{
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
            make.edges.equalToSuperview()
        }
    }
    
    /*func bindingData(with data: HotModel){
        DispatchQueue.main.async { [self] in
            if let imgUrl = URL(string: data.list.first?.thumbnail ?? ""){
                self.thumbnailImageView.kf.setImage(with: imgUrl)
            }
            self.titleLabel.text = data.list.first?.title
            self.contentLabel.text = data.list.first?.previewContent
            self.likeButton.setTitle("\((data.list.first?.likeCount)!)", for: .normal)
            self.hitButton.setTitle("\((data.list.first?.hit)!)", for: .normal)
            if ((data.list.first?.isLiked) != nil) {
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.tintColor(GlogAsset.Colors.paperStartColor.color), for: .normal)
            } else {
                self.likeButton.setImage(.init(named: "Paper_LikeLogo")?.tintColor(GlogAsset.Colors.paperGrayColor.color), for: .normal)
            }
        }
    }*/
}
