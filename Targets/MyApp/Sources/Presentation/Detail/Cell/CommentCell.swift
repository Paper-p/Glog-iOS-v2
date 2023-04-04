
import UIKit
import SnapKit
import Then

final class CommentCell: UITableViewCell {
    static let identifier = "CommentCell"
    
    private let profileImageView = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    private let nicknameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    private let contentLabel = UILabel().then {
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
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        contentView.addSubViews(profileImageView, nicknameLabel, contentLabel, createdAtLabel)
    }

    private func setLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(38)
            make.size.equalTo(36)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.top.equalTo(profileImageView.snp.top)
            make.width.equalTo(80)
            make.height.equalTo(19)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(nicknameLabel)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(1)
            make.width.equalTo(150)
            make.height.equalTo(16)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(38)
        }
    }
    
    func bindComment(model: DetailComment){
        nicknameLabel.text = model.author.nickname
        contentLabel.text = model.content
        createdAtLabel.text = model.createdAt.description
        DispatchQueue.main.async {
            if let image = URL(string: model.author.profileImageUrl){
                self.profileImageView.kf.setImage(with: image)
            }
        }
    }
}
