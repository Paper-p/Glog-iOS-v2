
import UIKit

struct DetailResponse: Codable{
    var id: Int
    var title: String
    var c: String
    var thumbnail: String?
    var createdAt: Date
    var hit: Int
    var likeCount: Int
    var isLiked: Bool
    var tagList: [String]
    var comments: [DetailComment]
    var isMine: Bool
}

struct DetailComment: Codable{
    var id: CLong
    var author: Author
    var content: String
    var createdAt: Date
    var isMine: Bool
}

struct Author: Codable{
    var userId: String
    var nickname: String
    var profileImageUrl: String
}
