
import UIKit

final class AuthTextField: UITextField{
    init(title: String){
        super.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor
        ])
        self.layer.cornerRadius = 10
        self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.layer.backgroundColor = GlogAsset.Colors.paperBlankColor.color.cgColor
        self.textColor = UIColor.gray
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
