
import Foundation

struct EditFeedRequest: Codable{
    var id: Int
    var title: String
    var content: String
    var thumbnail: String?
    var tags: [String]
}
