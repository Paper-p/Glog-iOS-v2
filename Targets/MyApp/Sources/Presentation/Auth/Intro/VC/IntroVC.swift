import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit

final class IntroVC: BaseVC<IntroVM>,Stepper {
    
    var steps = PublishRelay<Step>()
    
    private let backGroundImageView = UIImageView(image: UIImage(named: "Paper_Background")!)
    
    private let blurMainView = UIView().then{
        $0.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.52).cgColor
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setDefaults()
        blurFilter?.setValue(5, forKey: kCIInputRadiusKey)
        $0.layer.backgroundFilters?.append(blurFilter!)
        $0.layer.cornerRadius = 70
    }
    
    private let mainLogoImageView = UIImageView(image: UIImage(named: "Paper_MainLogo")!)
    
    private let mainLabel = UITextView().then{
        $0.text = "여기에서 너의 생각을 남들에게 이야기해봐"
        $0.backgroundColor = .clear
        $0.isSelectable = false
        $0.font = UIFont(name: "Helvetica", size: 14)
    }
    
    private let signInButton = UIButton().then{
        $0.titleLabel?.text = "로그인"
        $0.titleLabel?.textColor = PaperPAsset.Colors.paperBackgroundColor.color
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)!
        $0.layer.backgroundColor = PaperPAsset.Colors.paperStartColor.color.cgColor
    }
    
    private let signUpButton = UIButton().then{
        $0.titleLabel?.text = "회원가입"
        $0.titleLabel?.textColor = PaperPAsset.Colors.paperStartColor.color
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)!
        $0.layer.backgroundColor = PaperPAsset.Colors.paperBackgroundColor.color.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }
    
    override func addView(){
        [backGroundImageView,
         blurMainView,
         mainLogoImageView,
         mainLabel,
         signInButton,
         signUpButton
        ]
            .forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout(){
        backGroundImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(400)
            make.top.equalToSuperview()
        }
        blurMainView.snp.makeConstraints { make in
            make.centerX.equalTo(backGroundImageView)
            make.centerY.equalTo(backGroundImageView)
            make.size.equalTo(200)
        }
        mainLogoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(blurMainView)
            make.top.equalTo(blurMainView).offset(10)
            make.size.equalTo(140)
        }
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalTo(blurMainView)
            make.bottom.equalTo(mainLogoImageView).offset(10)
            make.width.equalTo(128)
            make.height.equalTo(42)
        }
        signInButton.snp.makeConstraints { make in
            make.centerX.equalTo(blurMainView)
            make.top.equalTo(blurMainView.snp.bottom).offset(150)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(signInButton)
            make.top.equalTo(signInButton.snp.bottom).offset(16)
        }
    }
}
