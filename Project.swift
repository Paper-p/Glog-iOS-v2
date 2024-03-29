import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "Glog"
let orginazationIden = "Glog"

let project = Project.executable(
    name: projectName,
    platform: .iOS,
    packages: [
        .Then,
        .SnapKit,
        .Alamofire,
        .Moya,
        .RxSwift,
        .KeychainSwift,
        .RxFlow,
        .Gifu,
        .Kingfisher,
        .Markdownosaur,
        .MarkupEditor,
        .RichTextKit,
        .SVGKit
    ],
    product: .app,
    deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone, .ipad]),
    dependencies: [
        .SPM.Then,
        .SPM.SnapKit,
        .SPM.Alamofire,
        .SPM.RxMoya,
        .SPM.RxSwift,
        .SPM.KeychainSwift,
        .SPM.RxFlow,
        .SPM.Gifu,
        .SPM.Kingfisher,
        .SPM.Markdownosaur,
        .SPM.MarkupEditor,
        .SPM.RichTextKit,
        .SPM.SVGKit
    ]
)
