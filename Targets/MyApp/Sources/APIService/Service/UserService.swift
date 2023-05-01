
import Foundation
import Moya

enum UserService{
    case userProfile(param: UserProfileRequest)
    case miniProfile
    case editNickname(param: EditNicknameRequest)
}

extension UserService: TargetType{
    public var baseURL: URL{
        return URL(string: GlogAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        case let .userProfile(nickname):
            return "user/\(nickname.nickname)"
            
        case .miniProfile:
            return "user/profile"
            
        case .editNickname:
            return "/nickname"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .userProfile:
            return .get
            
        case .miniProfile:
            return .get
            
        case .editNickname:
            return .patch
        }
    }
    
    var sampleData: Data{
        return "@@".data(using: .utf8)!
    }
    
    var task: Task{
        switch self {
        case .userProfile:
            return .requestPlain
            
        case .miniProfile:
            return .requestPlain
            
        case let .editNickname(param: param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        case .userProfile, .miniProfile, .editNickname:
            return ["Authorization" : "Bearer \(tk.read(key: "accessToken")!)"]
        default:
            return["Content-Type" : "application/json"]
        }
    }
}
