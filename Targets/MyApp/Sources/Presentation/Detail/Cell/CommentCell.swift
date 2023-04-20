
import UIKit
import SnapKit
import Then

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
    
    private let contentLabel = UITextView().then {
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
    
    private let optionButton = UIButton().then{
        $0.setImage(UIImage(systemName: "pencil")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        $0.isHidden = true
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(optionButtonDidTap), for: .touchUpInside)
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
        contentView.addSubViews(profileImageView, nicknameLabel, contentLabel, createdAtLabel, optionButton)
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
        
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(nicknameLabel)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(1)
            make.width.equalTo(150)
            make.height.equalTo(15)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(38)
        }
        
        optionButton.snp.makeConstraints { make in
            make.centerY.equalTo(createdAtLabel)
            make.left.equalTo(createdAtLabel.snp.right).offset(5)
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
        if model.isMine{
            self.optionButton.isHidden = false
            self.optionButton.isEnabled = true
        }
    }
    
    @objc func optionButtonDidTap(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAlert = UIAlertAction(title: "수정", style: .default) { _ in
            
        }
        let deleteAlert = UIAlertAction(title: "삭제", style: .destructive) { _ in
            
        }
        let cancelAlert = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(editAlert)
        alert.addAction(deleteAlert)
        alert.addAction(cancelAlert)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
    }
}
