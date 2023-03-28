
import UIKit

class FeedManager: Codable{
    static let share = FeedManager()
    
    var id: Int?
    
    private init() {}
}
