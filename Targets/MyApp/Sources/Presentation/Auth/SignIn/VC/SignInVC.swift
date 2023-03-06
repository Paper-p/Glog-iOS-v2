
import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit

final class SignInVC: BaseVC<SignInVM>, Stepper{
    
    var steps = PublishRelay<Step>()
    
    private let mainLogoImageView = UIImageView(image: UIImage(named: "Paper_MainLogo")!)
    
    private let welcomeLabel = UILabel().then{
        $0.text = "다시 온걸 환영해요!"
        $0.font = UIFont(name: "Helvetica-Bold", size: 20)
        $0.textColor = UIColor.white
    }
    
    private let idTextField = UITextField().then{
        $0.attributedPlaceholder = NSAttributedString(string: "아이디를 입력해주세요.", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor
        ])
        $0.layer.backgroundColor = GlogAsset.Colors.paperBlankColor.color.cgColor
        $0.textColor = UIColor.white
        $0.layer.cornerRadius = 10
        $0.font = UIFont(name: "Helvetica", size: 20)
    }
    
    private let pwdTextField = UITextField().then{
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요.", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor
        ])
        $0.layer.backgroundColor = GlogAsset.Colors.paperBlankColor.color.cgColor
        $0.textColor = UIColor.white
        $0.allowsEditingTextAttributes = true
        $0.font = UIFont(name: "Helvetica", size: 20)
    }
    
    private let signInButton = UIButton().then{
        $0.layer.cornerRadius = 10
        $0.titleLabel?.text = "로그인"
        $0.titleLabel?.textColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)!
        $0.layer.backgroundColor = GlogAsset.Colors.paperStartColor.color.cgColor
    }
    
    private let forgotPwdButton = UIButton().then{
        $0.titleLabel?.text = "비밀번호를 잊어 버리셨나요"
        $0.titleLabel?.textColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.layer.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        view.layer.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color.cgColor
    }
    
    override func addView(){
        [mainLogoImageView,
         welcomeLabel,
         idTextField,
         pwdTextField,
         signInButton,
         forgotPwdButton
        ]
            .forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout(){
        mainLogoImageView.snp.makeConstraints { make in
            make.left.equalTo(36)
            make.top.equalTo(150)
            make.width.equalTo(277)
            make.height.equalTo(96)
        }
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLogoImageView.snp.bottom).offset(20)
            make.width.equalTo(160)
            make.height.equalTo(24)
        }
        idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(35)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
        }
        pwdTextField.snp.makeConstraints { make in
            make.centerX.equalTo(idTextField)
            make.size.equalTo(idTextField)
            make.top.equalTo(idTextField.snp.bottom).offset(15)
        }
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pwdTextField.snp.bottom).offset(30)
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(45)
        }
        forgotPwdButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInButton.snp.bottom).offset(15)
        }
    }
}
