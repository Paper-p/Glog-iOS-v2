
import Foundation

struct PostListRequest: Codable{
    var size: Int = 12
    var page: Int
    let keyword: String
}
