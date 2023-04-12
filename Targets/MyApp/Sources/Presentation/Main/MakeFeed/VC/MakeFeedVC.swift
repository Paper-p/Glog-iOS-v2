import Foundation
import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Kingfisher
import Gifu

final class MakeFeedVC: BaseVC<MakeFeedVM>{
    
    
    var tagData: [String] = []
    
    private let makeButton = UIButton().then{
        $0.setImage(UIImage(systemName: "pencil.line")?.tintColor(GlogAsset.Colors.paperStartColor.color), for: .normal)
    }
    
    private let titleTextfield = UITextField().then{
        $0.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요", attributes: [
            .foregroundColor : GlogAsset.Colors.paperGrayColor.color,
            .font : UIFont.systemFont(ofSize: 26, weight: .bold)])
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        $0.borderStyle = .none
    }
    
    private let underLineView = UIView().then{
        $0.backgroundColor = GlogAsset.Colors.paperGrayColor.color
    }
    
    private let tagTextfield = UITextField().then{
        $0.attributedPlaceholder = NSAttributedString(string: "태그를 입력해주세요", attributes: [
            .foregroundColor : GlogAsset.Colors.paperGrayColor.color,
            .font : UIFont.systemFont(ofSize: 18, weight: .medium)])
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.borderStyle = .none
    }
    
    private var tagCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setup() {
        setCollectionView()
        self.tagTextfield.delegate = self
    }
    
    private func setCollectionView(){
        tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: tagLayout())
        tagCollectionView?.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        tagCollectionView?.delegate = self
        tagCollectionView?.dataSource = self
        tagCollectionView.isScrollEnabled = false
        tagCollectionView?.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        self.tagCollectionView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func tagLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(60),
            heightDimension: .absolute(30)
       )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(55)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(8)

        let section = NSCollectionLayoutSection(group: group).then{
            $0.interGroupSpacing = 12
            $0.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        }

        let config = UICollectionViewCompositionalLayoutConfiguration().then{
            $0.scrollDirection = .vertical
        }
        let layout = UICollectionViewCompositionalLayout(section: section).then{
            $0.configuration = config
        }
        
        return layout
        
    }
    
    override func configureNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: makeButton.imageView?.image, style: .plain, target: self, action: nil)
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Paper_MainLogo")?.withRenderingMode(.alwaysOriginal))
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    override func addView() {
        view.addSubViews(titleTextfield,underLineView,tagTextfield,tagCollectionView)
    }
    
    override func setLayout() {
        titleTextfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(55)
            make.centerX.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(titleTextfield.snp.bottom)
            make.height.equalTo(1)
            make.width.equalToSuperview().inset(12)
            make.centerX.equalTo(titleTextfield)
        }
        
        tagTextfield.snp.makeConstraints { make in
            make.top.equalTo(underLineView.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tagTextfield.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(56)
        }
    }
}

extension MakeFeedVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
        cell.tagLabel.text = tagData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tagData.remove(at: indexPath.item)
        print(tagData.description)
        tagCollectionView.reloadData()
    }
}

extension MakeFeedVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if tagTextfield.text?.isEmpty == false{
            tagData.append(tagTextfield.text!)
            print(tagData.description)
            tagTextfield.text = ""
            tagCollectionView.reloadData()
        }
        return true
    }
}
