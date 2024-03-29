
import Foundation

struct HotModel: Codable{
    var list: [HotPostList]?
}

struct HotPostList: Codable{
    var id: Int
    var title: String
    var createdAt: Date
    var thumbnail: String
    var previewContent: String
    var hit: Int
    var likeCount: Int
    var commentCount: Int
    var isLiked: Bool
    var tagList: [String]
}
