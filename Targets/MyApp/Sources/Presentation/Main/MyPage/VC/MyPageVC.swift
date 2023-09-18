import Then
import MapKit
import CoreLocation
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Gifu

final class MyPageVC: BaseVC<MyPageVM>{

    override func setup() {
        viewModel.fetchMiniProfile { _ in
            self.viewModel.fetchMyPage(completion: { _ in
            }, nickname: self.viewModel.miniProfileData?.nickname ?? "")
        }
    }
}
