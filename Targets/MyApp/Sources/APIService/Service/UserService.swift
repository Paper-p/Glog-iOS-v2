
import Foundation
import Moya

enum UserService{
    case userProfile(param: UserProfileRequest)
}

extension UserService: TargetType{
    public var baseURL: URL{
        return URL(string: GlogAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        case let .userProfile(nickname):
            return "user/\(nickname)"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .userProfile:
            return .get
        }
    }
    
    var sampleData: Data{
        return "@@".data(using: .utf8)!
    }
    
    var task: Task{
        switch self {
        case .userProfile:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        case .userProfile:
            return ["Authorization" : "Bearer \(tk.read(key: "accessToken")!)"]
        default:
            return["Content-Type" : "application/json"]
        }
    }
}
