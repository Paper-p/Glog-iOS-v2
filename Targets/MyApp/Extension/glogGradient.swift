
import AppKit

extension NSView{
    func glogGradient(){
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [PaperPAsset.Colors.paperStartColor.color.cgColor, PaperPAsset.Colors.paperEndColor.color.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer?.insertSublayer(gradient, at: 0)
        self.layer?.masksToBounds = true
    }
}
