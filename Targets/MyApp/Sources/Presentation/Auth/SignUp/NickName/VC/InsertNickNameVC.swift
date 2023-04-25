import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class InsertNickNameVC: BaseVC<InsertNicknameVM>, UITextFieldDelegate{
    
    let gifImage = GIFImageView()
    
    private let nicknameTextField = AuthTextField(title: "사용하실 닉네임을 입력해주세요.")
    
    private var doneButton = GlogButton(title: "완료",width: 366, height: 60).then{
        $0.addTarget(self, action: #selector(doneButtonDidTap), for: .touchUpInside)
        $0.isEnabled = false
    }
    
    private let errorLabel = UILabel().then{
        $0.text = "이미 존재하는 닉네임이에요."
        $0.textColor = GlogAsset.Colors.paperErrorColor.color
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color.cgColor
        doneButton.clearGradient()
    }
    
    override func configureNavigation() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Paper_MainLogo"))
    }
    
    override func setup() {
        DispatchQueue.main.async {
            self.gifImage.animate(withGIFNamed: "Paper_Smile", animationBlock: {})
        }
        nicknameTextField.addLeftImage(UIImage(systemName: "person.fill")!, x: 17, y: 5)
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: nicknameTextField)
    }
    
    override func addView(){
        [gifImage,
         nicknameTextField,
         doneButton,
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
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(52)
            make.top.equalTo(gifImage.snp.bottom).offset(20)
        }
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(doneButton.snp.bottom).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(17)
        }
    }
    
    private func insertUserNameData(){
        guard let userName = nicknameTextField.text else { return }
        let userInfo = SignUpModel.share
        userInfo.nickname = userName
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if !text.isEmpty && (text.count >= 4 && text.count <= 20){
                    doneButton.isEnabled = true
                    doneButton.createGradient()
                    print("working")
                }
                else{
                    doneButton.clearGradient()
                    doneButton.isEnabled = false
                    print("nooo")
                }
            }
        }
    }
    
    @objc func doneButtonDidTap(){
        viewModel.fetch(nickname: nicknameTextField.text!)
        insertUserNameData()
    }
    
    override func bindVM() {
        viewModel.errorLabelIsVisible.bind { [weak self] visible in
            DispatchQueue.main.async {
                self?.errorLabel.isHidden = visible ? true : false
            }
        }
    }
}
