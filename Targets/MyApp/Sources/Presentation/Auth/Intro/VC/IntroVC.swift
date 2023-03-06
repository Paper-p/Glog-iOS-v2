import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit

final class IntroVC: BaseVC<IntroVM> {
    
    private let backGroundImageView = UIImageView(image: UIImage(named: "Paper_Background")!)
    
    private let blurMainView = UIView().then{
        $0.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.52).cgColor
        $0.layer.cornerRadius = 112
    }
    
    private let mainLogoImageView = UIImageView(image: UIImage(named: "Paper_MainLogo")!)
    
    private let mainLabel = UITextView().then{
        $0.text = "여기에서 너의 생각을 남들에게 이야기해봐"
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.textAlignment = .center
        $0.isSelectable = false
        $0.font = UIFont(name: "Helvetica-Bold", size: 18)
    }
    
    private let signInButton = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(GlogAsset.Colors.paperBackgroundColor.color, for: .normal)
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)!
        $0.layer.backgroundColor = GlogAsset.Colors.paperStartColor.color.cgColor
    }
    
    private let signUpButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(GlogAsset.Colors.paperStartColor.color, for: .normal)
        $0.layer.borderColor = GlogAsset.Colors.paperEndColor.color.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)!
        $0.layer.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let gradientLayer = CAGradientLayer()
        gradientLayer.frame = signInButton.bounds
        gradientLayer.colors = [GlogAsset.Colors.paperStartColor.color, GlogAsset.Colors.paperEndColor.color]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [0.0, 1.0]
        signInButton.layer.insertSublayer(gradientLayer, at: 0)*/
    }
    
    private func bindViewModel() {
        let input = IntroVM.Input(
            signInButtonTap: signInButton.rx.tap.asObservable(),
            signUpButtonTap: signUpButton.rx.tap.asObservable()
        )
        viewModel.transVC(input: input)
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
            make.size.equalTo(720)
            make.top.equalTo(-130)
        }
        blurMainView.snp.makeConstraints { make in
            make.centerX.equalTo(backGroundImageView)
            make.top.equalToSuperview().offset(220)
            make.size.equalTo(272)
        }
        mainLogoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(80)
            make.centerY.equalTo(blurMainView)
            make.width.equalTo(187)
            make.height.equalTo(69)
        }
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalTo(blurMainView)
            make.bottom.equalTo(mainLogoImageView).offset(50)
            make.width.equalTo(128)
            make.height.equalTo(50)
        }
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-130)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(signInButton)
            make.top.equalTo(signInButton.snp.bottom).offset(16)
            make.width.equalTo(signInButton)
            make.height.equalTo(signInButton)
        }
    }
}

