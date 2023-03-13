
import UIKit

class SignUpModel: Codable{
    static let share = SignUpModel()
    
    var nickname: String?
    var userId: String?
    var password: String?
    
    private init() {}
}
