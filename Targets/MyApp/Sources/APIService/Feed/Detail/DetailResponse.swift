
import UIKit

struct DetailResponse: Codable{
    var id: Int
    var title: String
    var content: String
    var thumbnail: String?
    var createdAt: Date
    var hit: Int
    var likeCount: Int
    var isLiked: Bool
    var tagList: [String]
    var comments: [DetailComment]
    var author: Author
    var isMine: Bool
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
