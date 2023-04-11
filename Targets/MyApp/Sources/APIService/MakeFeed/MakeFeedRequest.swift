
import Foundation

struct MakeFeedRequest: Codable{
    let title: String
    let content: String
    let thumbnail: String?
    let tags: [String]
}
