
import UIKit

final class GlogButton: UIButton {
    init(title: String, width: Int, height: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.setTitle(title, for: .normal)
        self.setTitleColor(GlogAsset.Colors.paperBackgroundColor.color, for: .normal)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createGradient() {
        let gradientColors: [CGColor] = [GlogAsset.Colors.paperStartColor.color.cgColor, GlogAsset.Colors.paperEndColor.color.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.locations = [0,1]
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 10
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func clearGradient(){
        self.backgroundColor = GlogAsset.Colors.paperGrayColor.color
    }
}
