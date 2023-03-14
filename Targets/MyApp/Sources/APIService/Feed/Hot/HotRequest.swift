
import Foundation

struct HotRequest: Codable{
    let authorization: String?
    
    enum codingKeys: String, CodingKey{
        case authorization = "Authorization"
    }
}
