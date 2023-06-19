
import Foundation

struct PostListResponse: Codable{
    var size: Int
    var page: Int
    var list: [PostList]?
}

struct PostList: Codable{
    var id: Int
    var title: String
    var createdAt: Date
    var thumbnail: String?
    var previewContent: String
    var hit: Int
    var likeCount: Int
    var commentCount: Int
    var isLiked: Bool
    var tagList: [String]
}
