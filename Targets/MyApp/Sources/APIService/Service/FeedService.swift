
import Foundation
import Moya

enum FeedService{
    case hot
    case postList(keyword: PostListRequest)
}

extension FeedService: TargetType{
    public var baseURL: URL{
        return URL(string: GlogAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        case .hot:
            return "feed/hot"
        case .postList:
            return "feed/list"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .hot:
            return .get
        case .postList:
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
        case let .postList(keyword):
            return .requestParameters(parameters: ["size": keyword.size, "page": keyword.page, "keyword": keyword.keyword], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        case .hot, .postList:
            return ["Authorization" : "Bearer \(tk.read(key: "accessToken")!)"]
        default:
            return["Content-Type" : "application/json"]
        }
    }
}
