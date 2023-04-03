
import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit

final class SignInVC: BaseVC<SignInVM>{
    
    private let mainLogoImageView = UIImageView(image: UIImage(named: "Paper_MainLogo")!)
    
    private let welcomeLabel = UILabel().then{
        $0.text = "다시 온걸 환영해요!"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = UIColor.white
    }
    
    private let idTextField = AuthTextField(title: "아이디를 입력해주세요.").then{
        $0.text = "pasin7793"
    }
    
    private let pwdTextField = AuthTextField(title: "비밀번호를 입력해주세요.").then{
        $0.isSecureTextEntry = true
        $0.text = "wnsghk78*"
    }
    
    private let signInButton = GlogButton(title: "로그인").then{
        $0.addTarget(self, action: #selector(signInButtonDidTap), for: .touchUpInside)
    }
    
    private let forgotPwdButton = UIButton().then{
        $0.setTitle("비밀번호", for: .normal)
        $0.setTitleColor(GlogAsset.Colors.paperEndColor.color, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    private let forgotPwdLabel = UILabel().then{
        $0.text = "를 잊어 버리셨나요?"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color.cgColor
        signInButton.createGradient()
    }
    
    override func configureNavigation() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = "취소"
    }
    
    override func setup() {
        idTextField.addLeftImage(UIImage(systemName: "person.fill")!, x: 17, y: 5)
        pwdTextField.addLeftImage(UIImage(systemName: "lock.fill")!, x: 17, y: 4)
    }
    
    override func addView(){
        [mainLogoImageView,
         welcomeLabel,
         idTextField,
         pwdTextField,
         signInButton,
         forgotPwdButton,
         forgotPwdLabel
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
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(52)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(38)
        }
        pwdTextField.snp.makeConstraints { make in
            make.centerX.equalTo(idTextField)
            make.size.equalTo(idTextField)
            make.top.equalTo(idTextField.snp.bottom).offset(12)
        }
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pwdTextField.snp.bottom).offset(32)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        forgotPwdButton.snp.makeConstraints { make in
            make.left.equalTo(116)
            make.top.equalTo(signInButton.snp.bottom).offset(15)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        forgotPwdLabel.snp.makeConstraints { make in
            make.centerY.equalTo(forgotPwdButton)
            make.left.equalTo(forgotPwdButton.snp.right).offset(1)
            make.width.equalTo(148)
            make.height.equalTo(20)
        }
    }
    
    @objc func signInButtonDidTap(){
        guard let id = idTextField.text else {return}
        guard let pwd = pwdTextField.text else {return}
        
        if !id.isEmpty && !pwd.isEmpty == true{
            print("good")
            viewModel.fetch(id: idTextField.text!, pwd: pwdTextField.text!)
        } else {
            print("bad")
        }
    }
}
