import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit

final class InsertPwdVC: BaseVC<InsertPwdVM>, Stepper{
    
    var steps = PublishRelay<Step>()
    
    private let mainLogoImageView = UIImageView(image: UIImage(named: "Paper_Smile")!)
    
    private let backButton = UIButton().then{
        //$0.image = UIImage(systemSymbolName: "chevron.backward", accessibilityDescription: "back")
        $0.layer.backgroundColor = UIColor.white.cgColor
    }
    
    private let pwdTextField = UITextField().then{
        $0.placeholder = "사용할 비밀번호 입력해주세요."
        $0.attributedPlaceholder = NSAttributedString(string: "사용할 비밀번호 입력해주세요.", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor
        ])
        $0.layer.backgroundColor = PaperPAsset.Colors.paperBlankColor.color.cgColor
        $0.textColor = UIColor.white
        $0.font = UIFont(name: "Helvetica", size: 20)
    }
    
    private let rePwdTextField = UITextField().then{
        $0.placeholder = "사용할 비밀번호 한번더 입력해주세요."
        $0.attributedPlaceholder = NSAttributedString(string: "사용할 비밀번호 한번더 입력해주세요.", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor
        ])
        $0.layer.backgroundColor = PaperPAsset.Colors.paperBlankColor.color.cgColor
        $0.textColor = UIColor.white
        $0.font = UIFont(name: "Helvetica", size: 20)
    }
    
    private let nextButton = UIButton().then{
        $0.layer.cornerRadius = 10
        $0.titleLabel?.text = "다음"
        $0.titleLabel?.textColor = PaperPAsset.Colors.paperBackgroundColor.color
        $0.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
        $0.layer.backgroundColor = PaperPAsset.Colors.paperBlankColor.color.cgColor
    }
    
    private let includeLabel = UILabel().then{
        $0.text = "비밀번호는 8자리 이상 및 기호를 포함해주세요."
        $0.font = UIFont(name: "Helvetica", size: 14)
        $0.textColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        view.layer.backgroundColor = PaperPAsset.Colors.paperBackgroundColor.color.cgColor
    }
    
    override func addView(){
        [mainLogoImageView,
         backButton,
         pwdTextField,
         rePwdTextField,
         nextButton,
         includeLabel
        ]
            .forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout(){
        mainLogoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(30)
            make.width.equalTo(170)
            make.height.equalTo(100)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.size.equalTo(20)
        }
        pwdTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(35)
            make.top.equalTo(mainLogoImageView.snp.bottom).offset(20)
        }
        rePwdTextField.snp.makeConstraints { make in
            make.centerX.equalTo(pwdTextField)
            make.size.equalTo(pwdTextField)
            make.top.equalTo(pwdTextField.snp.bottom).offset(15)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rePwdTextField.snp.bottom).offset(30)
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(45)
        }
        includeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nextButton.snp.bottom).offset(17)
            make.width.equalTo(280)
            make.height.equalTo(17)
        }
    }
}
