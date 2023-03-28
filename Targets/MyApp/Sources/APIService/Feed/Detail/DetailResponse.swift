
import UIKit

struct DetailResponse: Codable{
    let id: Int
    let title: String
    let content: String
    let thumbnail: String?
    let createdAt: Date
    let hit: Int
    let likeCount: Int
    let isLiked: Bool
    let tagList: [String]
    let comments: [DetailComment]
    let isMine: Bool
}

struct DetailComment: Codable{
    let id: CLong
    let author: Author
    let content: String
    let createdAt: Date
    let isMine: Bool
}

struct Author: Codable{
    let userId: String
    let nickname: String
    let profileImageUrl: String
}
