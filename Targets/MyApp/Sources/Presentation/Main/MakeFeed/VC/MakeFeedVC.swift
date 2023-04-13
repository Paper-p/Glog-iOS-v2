import Foundation
import Markdown
import Markdownosaur
import Then
import RxFlow
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import Kingfisher
import Gifu
import MarkupEditor
import RichTextKit

final class MakeFeedVC: BaseVC<MakeFeedVM>{
    
    private let segmentedControl = UISegmentedControl(items: ["글작성", "미리보기"]).then{
        $0.selectedSegmentTintColor = GlogAsset.Colors.paperStartColor.color
        $0.selectedSegmentIndex = 0
        $0.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    private let codeView = UITextView().then{
        $0.textColor = .white
        $0.backgroundColor = GlogAsset.Colors.paperStartColor.color
        $0.translatesAutoresizingMaskIntoConstraints = true
        $0.sizeToFit()
        $0.isScrollEnabled = false
    }
    private let preView = UITextView().then{
        $0.isEditable = false
        $0.backgroundColor = GlogAsset.Colors.paperBackgroundColor.color
        $0.translatesAutoresizingMaskIntoConstraints = true
        $0.sizeToFit()
        $0.isScrollEnabled = false
    }
    
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
        codeView.delegate = self
        textViewDidChange(codeView)
        textViewDidEndEditing(codeView)
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
        
        view.addSubViews(titleTextfield,underLineView,tagTextfield,tagCollectionView,segmentedControl, preView,codeView)
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
        
        segmentedControl.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.top.equalTo(tagCollectionView.snp.bottom)
        }
        
        codeView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.equalTo(segmentedControl)
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(97)
        }
        
        preView.snp.makeConstraints { make in
            make.top.equalTo(codeView)
            make.left.equalTo(codeView)
            make.width.equalTo(codeView)
            make.centerX.equalTo(codeView)
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        let selection = sender.selectedSegmentIndex
        switch selection {
        case 0:
            codeView.isHidden = false
            preView.isHidden = true
            
        case 1:
            codeView.isHidden = true
            preView.isHidden = false
            
        default:
            break
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
            tagTextfield.becomeFirstResponder()
            tagData.append(tagTextfield.text!)
            print(tagData.description)
            tagTextfield.text = ""
            tagCollectionView.reloadData()
        }
        return true
    }
    
}

extension MakeFeedVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width * 0.7, height: .greatestFiniteMagnitude)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let document = Document(parsing: codeView.text)
        var markdownsaur = Markdownosaur()
        let markdownString = markdownsaur.attributedString(from: document)
        preView.attributedText = markdownString
        preView.textColor = .white
    }
}
