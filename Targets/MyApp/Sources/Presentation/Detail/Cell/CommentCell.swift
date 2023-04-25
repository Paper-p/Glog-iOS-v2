
import UIKit
import SnapKit
import Then
import Moya

final class CommentCell: UITableViewCell {
    var model: DetailResponse?
    
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
    
    private let contentTextView = UITextView().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.isSelectable = false
        $0.isEditable = false
        $0.sizeToFit()
        $0.isScrollEnabled = false
        $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private let createdAtLabel = UILabel().then{
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        contentView.addSubViews(profileImageView, nicknameLabel, contentTextView, createdAtLabel)
    }

    private func setLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(12)
            make.size.equalTo(36)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.top.equalTo(profileImageView.snp.top)
            make.width.equalTo(80)
            make.height.equalTo(19)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.left.equalTo(nicknameLabel)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(1)
            make.width.equalTo(230)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(38)
        }
    }
    
    func bindComment(model: DetailComment){
        nicknameLabel.text = model.author.nickname
        contentTextView.text = model.content
        createdAtLabel.text = model.createdAt.toGlogDateString()
        DispatchQueue.main.async {
            if let image = URL(string: model.author.profileImageUrl){
                self.profileImageView.kf.setImage(with: image)
            }
        }
    }
}
