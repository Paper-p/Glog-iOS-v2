
import Foundation

struct UserProfileResponse: Codable{
    var userId: String
    var nickname: String
    var profileImageUrl: String
    var feedList: [FeedList]
    var isMine: Bool
}

struct FeedList: Codable{
    let id: Int
    let title: String
    let createdAt: Date
    let thumbnail: String?
    let previewContent: String
    let hit: Int
    let likeCount: Int
    let isLiked: Bool
    let tagList: [String]
}
