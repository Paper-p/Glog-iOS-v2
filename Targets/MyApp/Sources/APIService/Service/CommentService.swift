
import Foundation
import Moya

enum CommentService{
    case addComment(param: CommentRequest)
}

extension CommentService: TargetType{
    public var baseURL: URL{
        return URL(string: GlogAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        case let .addComment(param):
            return "comment/\(param)"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .addComment:
            return .post
        }
    }
    
    var sampleData: Data{
        return "@@".data(using: .utf8)!
    }
    
    var task: Task{
        switch self {
        case .addComment(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        case .addComment:
            return ["RefreshToken" : tk.read(key: "refreshToken")!]
        default:
            return["Content-Type" : "application/json"]
        }
    }
}
