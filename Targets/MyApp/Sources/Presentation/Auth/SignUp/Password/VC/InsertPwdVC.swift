import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class InsertPwdVC: BaseVC<InsertPwdVM>, UITextFieldDelegate{
    
    let gifImage = GIFImageView()
    
    private let pwdTextField = AuthTextField(title: "사용하실 비밀번호를 입력해주세요.")
    
    private let rePwdTextField = AuthTextField(title: "사용하실 비밀번호를 한번 더 입력해주세요.")
    
    private var nextButton = GlogButton(title: "다음")
    
    private let errorLabel = UILabel().then{
        $0.text = "이미 존재하는 아이디에요."
        $0.textColor = GlogAsset.Colors.paperErrorColor.color
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color.cgColor
        nextButton.clearGradient()
    }
    
    override func configureNavigation() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = "취소"
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Paper_MainLogo"))
    }
    
    override func setup() {
        pwdTextField.delegate = self
        DispatchQueue.main.async {
            self.gifImage.animate(withGIFNamed: "Paper_Smile", animationBlock: {})
        }
        pwdTextField.addLeftImage(UIImage(systemName: "lock.fill")!, x: 17, y: 4)
        rePwdTextField.addLeftImage(UIImage(systemName: "lock.fill")!, x: 17, y: 4)
    }
    
    override func addView(){
        [gifImage,
         pwdTextField,
         rePwdTextField,
         nextButton,
         errorLabel
        ]
            .forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout(){
        gifImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(140)
            make.height.equalTo(135)
            make.width.equalTo(170)
        }
        pwdTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(52)
            make.top.equalTo(gifImage.snp.bottom).offset(15)
        }
        
        rePwdTextField.snp.makeConstraints { make in
            make.centerX.equalTo(pwdTextField)
            make.size.equalTo(pwdTextField)
            make.top.equalTo(pwdTextField.snp.bottom).offset(12)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rePwdTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nextButton.snp.bottom).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(17)
        }
    }
}
