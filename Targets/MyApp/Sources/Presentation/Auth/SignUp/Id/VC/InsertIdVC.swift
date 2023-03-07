
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
    
    private let idTextField = AuthTextField(title: "사용하실 아이디를 입력해주세요.")
    
    private let nextButton = UIButton().then{
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color.cgColor
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
}
