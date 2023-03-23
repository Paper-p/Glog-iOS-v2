
import Foundation

struct PostListRequest: Codable{
    var size: Int = 4
    var page: Int = 0
    let keyword: String
}
