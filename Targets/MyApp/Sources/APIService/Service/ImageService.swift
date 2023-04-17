
import Foundation
import Moya
import UIKit

enum ImageService{
    case uploadImage(image: UIImage)
}

extension ImageService: TargetType{
    public var baseURL: URL{
        return URL(string: GlogAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        case .uploadImage:
            return "/image"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .uploadImage:
            return .post
        }
    }
    
    var sampleData: Data{
        return "@@".data(using: .utf8)!
    }
    
    var task: Task{
        switch self {
        case let .uploadImage(image):
            let imageData = MultipartFormData(provider: .data(image.jpegData(compressionQuality: 1.0)!), name: "image", fileName: "jpeg", mimeType: "image/jpeg")
            return .uploadMultipart([imageData])
        }
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        case .uploadImage:
            return ["Authorization" : "Bearer \(tk.read(key: "accessToken")!)", "Content-Type": "multipart/form-data"]
        default:
            return .none
        }
    }
}
