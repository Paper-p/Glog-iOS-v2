
import Foundation
import Moya

enum FeedService{
    case hot
    case postList(keyword: PostListRequest)
    case detail(param: DetailRequest)
    case like(param: DetailRequest)
    case cancelLike(param: DetailRequest)
    case makeFeed(param: MakeFeedRequest)
    case deleteFeed(param: DetailRequest)
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
        case let .detail(id):
            return "feed/\(id.id)"
        case let .like(id):
            return "feed/like/\(id.id)"
        case let .cancelLike(id):
            return "feed/like/\(id.id)"
        case .makeFeed:
            return "feed"
        case let .deleteFeed(id):
            return "feed/\(id.id)"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .hot:
            return .get
        case .postList:
            return .get
        case .detail:
            return .get
        case .like:
            return .post
        case .cancelLike:
            return .delete
        case .makeFeed:
            return .post
        case .deleteFeed:
            return .delete
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
        case .detail:
            return .requestPlain
        case .like:
            return .requestPlain
        case .cancelLike:
            return .requestPlain
        case let .makeFeed(param: param):
            return .requestParameters(parameters: ["title":param.title,
                                                   "content": param.content,
                                                   "thumbnail": param.thumbnail,
                                                   "tags": param.tags], encoding: JSONEncoding.default)
        case .deleteFeed:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        case .hot, .postList, .detail, .like, .cancelLike, .makeFeed, .deleteFeed:
            return ["Authorization" : "Bearer \(tk.read(key: "accessToken")!)"]
        default: 
            return["Content-Type" : "application/json"]
        }
    }
}
