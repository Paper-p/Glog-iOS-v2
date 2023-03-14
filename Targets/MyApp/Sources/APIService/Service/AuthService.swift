
import Foundation
import Moya

enum AuthService{
    case signIn(param: SignInRequest)
    case signUp(param: SignUpRequest)
    case refresh(param: RefreshRequest)
    case validId(keyword: ValidIdRequest)
    case validNickname(keyword: ValidNameRequest)
}

extension AuthService: TargetType{
    public var baseURL: URL{
        return URL(string: PaperAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        case .signIn:
            return "/auth/signin"
        case .refresh:
            return "/auth/"
        case .signUp:
            return "/auth/signup"
        case .validId:
            return "/auth/valid-id"
        case .validNickname:
            return "/auth/valid-name"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .signIn, .signUp:
            return .post
        case .refresh:
            return .patch
        case .validId:
            return .head
        case .validNickname:
            return .head
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task{
        switch self {
        case let .signIn(param):
            return .requestJSONEncodable(param)
        case let .signUp(param):
            return .requestJSONEncodable(param)
        case .refresh:
            return .requestPlain
        case let .validId(keyword):
            return .requestParameters(parameters: ["userId":keyword.userId], encoding: URLEncoding.queryString)
        case let .validNickname(keyword):
            return .requestParameters(parameters: ["nickname":keyword.nickname], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]?{
        switch self {
        default:
            return["Content-Type" : "application/json"]
        }
    }
}
