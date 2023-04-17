
import Foundation
import Moya

enum ImageService{
    case uploadImage([Data])
}

extension ImageService: TargetType{
    public var baseURL: URL{
        return URL(string: GlogAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        case .uploadImage:
            return ""
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
        case let .uploadImage(datas):
            let multiparts = datas.map { data -> MultipartFormData in
                let uuid = UUID().uuidString
                return MultipartFormData(provider: .data(data),
                                         name: "file",
                                         fileName: "\(uuid).png"
                )
            }
            return .uploadMultipart(multiparts)
        }
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        case .uploadImage:
            return ["Authorization" : "Bearer \(tk.read(key: "accessToken")!)", "content-type": "multipart/form-data"]
        default:
            return .none
        }
    }
}
