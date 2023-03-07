
import UIKit

extension UITextField {
    
    func addLeftImage(_ image: UIImage, x: Float, y: Float) {
        let iconView = UIImageView(frame:CGRect(x: CGFloat(x), y: CGFloat(y), width: image.size.width, height: image.size.height))
        iconView.image = image
        iconView.tintColor = .gray
        let iconContainerView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: 45, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
