
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
}
