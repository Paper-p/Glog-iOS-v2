import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class MainVC: BaseVC<MainVM>{
    
    private let mainLabel = UILabel().then{
        $0.text = "너의 생각을 글로 표현해봐!"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private let gifImage = GIFImageView()
    
    private let makeFeedButton = GlogButton(title: "게시글 작성하러 가기")
    
    private let hotTextView = UITextView().then{
        $0.backgroundColor = GlogAsset.Colors.paperBlankColor.color
        $0.layer.cornerRadius = 10
        $0.text = "🔥HOT’"
        $0.textColor = GlogAsset.Colors.paperGrayColor.color
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.isSelectable = false
        $0.isEditable = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setup() {
        DispatchQueue.main.async {
            self.gifImage.animate(withGIFNamed: "Paper_Smile", animationBlock: {})
        }
        makeFeedButton.createGradient()
    }
    
    override func addView() {
        [mainLabel,
         gifImage,
         makeFeedButton,
         hotTextView
        ].forEach{
            view.addSubview($0)
        }
    }
    
    override func configureNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperMainLogo.image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: .none)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: GlogAsset.Images.paperProfileLogo.image.downSample(size: .init(width: 36, height: 36)).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: .none)
    }
    
    override func setLayout() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(123)
            make.left.equalTo(12)
            make.width.equalTo(230)
            make.height.equalTo(98)
        }
        
        gifImage.snp.makeConstraints { make in
            make.centerY.equalTo(mainLabel)
            make.right.equalTo(12)
            make.height.equalTo(135)
            make.width.equalTo(165)
        }
        
        makeFeedButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(28)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        
        hotTextView.snp.makeConstraints { make in
            make.top.equalTo(makeFeedButton.snp.bottom).offset(72)
            make.left.equalTo(makeFeedButton)
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
    }
    
    @objc func profileButtonDidTap(){
        
    }
}
