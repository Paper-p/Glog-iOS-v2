import Then
import Markdownosaur
import Markdown
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class DetailVC: BaseVC<DetailVM>{
    
    private let thumbnailImageView = UIImageView()
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        $0.textColor = UIColor.white
        $0.sizeToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.detailPost(id: viewModel.id) { _ in
            self.bindVM()
        }
    }
    
    override func addView() {
        view.addSubViews(thumbnailImageView, titleLabel)
    }
    
    override func setLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            
        }
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    override func bindVM() {
        DispatchQueue.main.async {
            self.thumbnailImageView.kf.setImage(with: URL(string: self.viewModel.detailData?.thumbnail ?? ""))
            self.titleLabel.text = self.viewModel.detailData?.title
        }
    }
}
