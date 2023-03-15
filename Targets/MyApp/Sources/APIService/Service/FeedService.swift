
import Foundation
import Moya

enum FeedService{
    case hot
}

extension FeedService: TargetType{
    public var baseURL: URL{
        return URL(string: GlogAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        case .hot:
            return "feed/hot"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .hot:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task{
        switch self {
        case .hot:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        case .hot:
            return ["Authorization" : tk.read(key: "accessToken")!]
        default:
            return["Content-Type" : "application/json"]
        }
    }
}
