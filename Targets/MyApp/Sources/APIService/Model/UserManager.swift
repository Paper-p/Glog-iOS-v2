
import Foundation

struct UserManager: Codable{
    let accessToken: String
    let refreshToken: String
    let expiredAt: Date
}
