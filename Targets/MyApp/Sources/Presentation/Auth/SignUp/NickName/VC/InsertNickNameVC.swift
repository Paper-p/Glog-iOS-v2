import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit

final class InsertNickNameVC: BaseVC<InsertNicknameVM>, Stepper{
    
    var steps = PublishRelay<Step>()
    
    private let mainLogoImageView = UIImageView(image: UIImage(named: "Paper_Smile")!)
    
    private let backButton = UIButton().then{
        //image
        $0.layer.backgroundColor = UIColor.white.cgColor
    }
    
    private let idTextField = UITextField().then{
        
        $0.placeholder = "사용할 닉네임 입력"
        $0.attributedPlaceholder = NSAttributedString(string: "사용할 닉네임 입력", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor
        ])
        $0.layer.backgroundColor = GlogAsset.Colors.paperBlankColor.color.cgColor
        $0.textColor = UIColor.white
        $0.font = UIFont(name: "Helvetica", size: 20)
    }
    
    private let doneButton = UIButton().then{
        $0.layer.cornerRadius = 10
        $0.titleLabel?.text = "완료"
        $0.titleLabel?.textColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)!
        $0.layer.backgroundColor = GlogAsset.Colors.paperBlankColor.color.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        view.layer.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color.cgColor
    }
    
    override func addView(){
        [mainLogoImageView,
         backButton,
         idTextField,
         doneButton
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
        idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(35)
            make.top.equalTo(mainLogoImageView.snp.bottom).offset(20)
        }
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(idTextField.snp.bottom).offset(30)
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(45)
        }
    }
}
