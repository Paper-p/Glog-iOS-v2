
import Foundation

struct UserProfileResponse: Codable{
    var userId: String
    var nickname: String
    var profileImageUrl: String
    var feedList: [PostList]
    var isMine: Bool
}
