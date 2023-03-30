
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import Kingfisher

final class TagCollectionViewCell: BaseCollectionViewCell{
    
    static let identifier = "TagCollectionViewCell"
    
    let tagLabel = UILabel().then{
        $0.textColor = GlogAsset.Colors.paperBlankColor.color
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = GlogAsset.Colors.paperStartColor.color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    override func addView(){
        contentView.addSubViews(tagLabel)
    }
    
    override func setLayout(){
        tagLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    
    func bind(with model: DetailResponse){
        tagLabel.text = model.tagList.joined(separator: "")
    }
}
