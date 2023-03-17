
import Foundation

struct PostListResponse: Codable{
    let size: Int
    let page: Int
    let list: [PostList]
}

struct PostList: Codable{
    let id: Int
    let title: String
    let createdAt: Date
    let thumbnail: String?
    let previewContent: String
    let hit: Int
    let likeCount: Int
    let commentCount: Int
    let isLiked: Bool
    let tagList: [String]
}
