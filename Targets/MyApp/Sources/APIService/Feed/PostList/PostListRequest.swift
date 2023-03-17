
import Foundation

struct PostListRequest: Codable{
    var size: Int = 5
    var page: Int = 0
    let keyword: String
}
