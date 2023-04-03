
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
    
    func addRightPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
    func commentPadding(){
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: self.frame.height))
        self.rightView = rightPaddingView
        self.rightViewMode = ViewMode.always
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = leftPaddingView
        self.rightViewMode = ViewMode.always
    }
}
