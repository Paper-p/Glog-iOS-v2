
import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class InsertIdVC: BaseVC<InsertIdVM>, Stepper{
    
    var steps = PublishRelay<Step>()
    
    let gifImage = GIFImageView()
    
    private let idTextField = AuthTextField(title: "사용하실 아이디를 입력해주세요.").then{
        $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private var nextButton = GlogButton(title: "다음")
    
    private let errorLabel = UILabel().then{
        $0.text = "이미 존재하는 아이디에요."
        $0.textColor = GlogAsset.Colors.paperErrorColor.color
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
        DispatchQueue.main.async {
            self.gifImage.animate(withGIFNamed: "Paper_Smile", animationBlock: {})
        }
        idTextField.addLeftImage(UIImage(systemName: "person.fill")!, x: 17, y: 5)
    }
    
    override func addView(){
        [gifImage,
         idTextField,
         nextButton
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
    }
    @objc func textFieldDidChange(sender: UITextField) {
        if sender.text?.isEmpty == true {
            self.nextButton.isEnabled = false
            nextButton.clearGradient()
        } else {
            self.nextButton.isEnabled = true
            print("working")
            nextButton.createGradient()
        }
    }
}
