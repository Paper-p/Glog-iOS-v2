
import UIKit
import SnapKit
import Then
import Moya

final class CommentCell: UITableViewCell {
    
    static let identifier = "CommentCell"
    
    private let profileImageView = UIImageView(image: UIImage(systemName: "person.crop.circle")).then{
        $0.layer.cornerRadius = 17
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
        $0.contentMode = .scaleToFill
        $0.layer.masksToBounds = true
    }
    
    private let nicknameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    private let contentLabel = UILabel().then {
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    private let createdAtLabel = UILabel().then{
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        self.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        contentView.addSubViews(profileImageView, nicknameLabel, contentLabel, createdAtLabel)
    }

    private func setLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.size.equalTo(36)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(14)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.left.equalTo(nicknameLabel.snp.right).offset(8)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.left.equalTo(nicknameLabel)
        }
    }
    
    func bindComment(model: DetailComment){
        nicknameLabel.text = model.author.nickname
        contentLabel.text = model.content
        createdAtLabel.text = model.createdAt.toGlogDateString()
        DispatchQueue.main.async {
            if let image = URL(string: model.author.profileImageUrl){
                self.profileImageView.kf.setImage(with: image)
            }
        }
    }
}
