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
    
    private let pwdTextField = AuthTextField(title: "사용하실 비밀번호를 입력해주세요.").then{
        $0.isSecureTextEntry = true
    }
    private let rePwdTextField = AuthTextField(title: "사용하실 비밀번호를 한번 더 입력해주세요.").then{
        $0.isSecureTextEntry = true
    }
    
    private var nextButton = GlogButton(title: "다음",width: 366, height: 60).then{
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    private let errorLabel = UILabel().then{
        $0.text = "비밀번호는 8자리 이상 및 기호를 포함해주세요."
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
        rePwdTextField.delegate = self
        DispatchQueue.main.async {
            self.gifImage.animate(withGIFNamed: "Paper_Smile", animationBlock: {})
        }
        pwdTextField.addLeftImage(UIImage(systemName: "lock.fill")!, x: 17, y: 4)
        rePwdTextField.addLeftImage(UIImage(systemName: "lock.fill")!, x: 17, y: 4)
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: pwdTextField)
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: rePwdTextField)
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
            make.width.equalTo(280)
            make.height.equalTo(17)
        }
    }
    
    private func insertUserPwdData(){
        guard let password = pwdTextField.text else { return }
        let userInfo = SignUpModel.share
        userInfo.password = password
    }
    
    func checkPwdValidation(){
        
        if pwdTextField.text!.elementsEqual(rePwdTextField.text!){
            if passwordValidation(password: pwdTextField.text!) && rePasswordValidation(password: rePwdTextField.text!){
                viewModel.pushToNicknameVC()
            }
        } else{
            errorLabel.textColor = GlogAsset.Colors.paperErrorColor.color
            pwdTextField.layer.borderColor = GlogAsset.Colors.paperErrorColor.color.cgColor
            rePwdTextField.layer.borderColor = GlogAsset.Colors.paperErrorColor.color.cgColor
            pwdTextField.layer.borderWidth = 1
            rePwdTextField.layer.borderWidth = 1
        }
    }
    
    func passwordValidation(password: String) -> Bool {
        return viewModel.isValidPassword(password: password)
    }
    
    func rePasswordValidation(password: String) -> Bool{
        return viewModel.isValidPassword(password: password)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if !text.isEmpty && (text.count >= 8 && text.count <= 40){
                    nextButton.isEnabled = true
                    print("working")
                }
            }
        }
        if !pwdTextField.text!.isEmpty && (pwdTextField.text!.count >= 8 && pwdTextField.text!.count <= 40) && !rePwdTextField.text!.isEmpty && (rePwdTextField.text!.count >= 8 && rePwdTextField.text!.count <= 40){
            nextButton.createGradient()
        }
    }
    
    @objc func nextButtonDidTap(){
        
        if !pwdTextField.text!.isEmpty && (pwdTextField.text!.count >= 8 && pwdTextField.text!.count <= 40) && !rePwdTextField.text!.isEmpty && (rePwdTextField.text!.count >= 8 && rePwdTextField.text!.count <= 40){
            print("asdf")
            checkPwdValidation()
            insertUserPwdData()
            print(pwdTextField.text!)
            print(rePwdTextField.text!)
        }
    }
}
