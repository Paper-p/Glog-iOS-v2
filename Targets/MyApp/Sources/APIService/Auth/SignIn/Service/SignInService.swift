
import Foundation
import Moya

enum SignInService{
    case signIn(param: SignInRequest)
    case signUp(param: SignUpRequest)
    case refresh(param: RefreshRequest)
}

extension SignInService: TargetType{
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
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .signIn, .signUp:
            return .post
        case .refresh:
            return .patch
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
        }
    }
    
    var headers: [String : String]?{
        switch self {
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
