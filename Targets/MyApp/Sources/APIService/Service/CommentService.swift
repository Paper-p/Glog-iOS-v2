
import Foundation
import Moya

enum CommentService{
    case addComment(param: CommentRequest)
    case deleteComment(param: CommentRequest)
}

extension CommentService: TargetType{
    public var baseURL: URL{
        return URL(string: GlogAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        case let .addComment(id):
            return "comment/\(id.id)"
        case let .deleteComment(id):
            return "comment/\(id.id)"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .addComment:
            return .post
        case .deleteComment:
            return .delete
        }
    }
    
    var sampleData: Data{
        return "@@".data(using: .utf8)!
    }
    
    var task: Task{
        switch self {
        case .addComment(let param):
            return .requestParameters(parameters: ["content": param.content], encoding: JSONEncoding.default)
        case .deleteComment:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        case .addComment, .deleteComment:
            return ["Authorization" : "Bearer \(tk.read(key: "accessToken")!)"]
        default:
            return["Content-Type" : "application/json"]
        }
    }
}
