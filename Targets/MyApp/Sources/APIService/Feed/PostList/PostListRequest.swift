
import Foundation

struct PostListRequest: Codable{
    let size: Int
    let page: Int
    let keyword: String
}
