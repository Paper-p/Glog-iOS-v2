
import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class InsertIdVC: BaseVC<InsertIdVM>, UITextFieldDelegate{
    
    let gifImage = GIFImageView()
    
    private let idTextField = AuthTextField(title: "사용하실 아이디를 입력해주세요.")
    
    private var nextButton = GlogButton(title: "다음").then{
        $0.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        $0.isEnabled = false
    }
    
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
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Paper_MainLogo"))
    }
    
    override func setup() {
        idTextField.delegate = self
        DispatchQueue.main.async {
            self.gifImage.animate(withGIFNamed: "Paper_Smile", animationBlock: {})
        }
        idTextField.addLeftImage(UIImage(systemName: "person.fill")!, x: 17, y: 5)
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: idTextField)

    }
    
    override func addView(){
        [gifImage,
         idTextField,
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
        idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(52)
            make.top.equalTo(gifImage.snp.bottom).offset(20)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(idTextField.snp.bottom).offset(20)
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
    
    private func insertUserIdData(){
        guard let userId = idTextField.text else { return }
        let userInfo = SignUpModel.share
        userInfo.userId = userId
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if !text.isEmpty && (text.count >= 4 && text.count <= 20){
                    nextButton.isEnabled = true
                    nextButton.createGradient()
                    print("working")
                }
                else{
                    nextButton.clearGradient()
                    nextButton.isEnabled = false
                    print("nooo")
                }
            }
        }
    }
    
    @objc func nextButtonDidTap(){
        viewModel.fetch(id: idTextField.text!)
        insertUserIdData()
    }
    
    override func bindVM() {
//        viewModel.errorLabelIsVisible.bind { [weak self] visible in
//            DispatchQueue.main.async {
//                self?.errorLabel.isHidden = visible ? true : false
//            }
//        }
    }
}
