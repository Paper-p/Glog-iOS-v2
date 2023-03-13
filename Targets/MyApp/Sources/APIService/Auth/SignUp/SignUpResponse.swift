
import Foundation

struct SignUpResponse: Codable{
    let accessToken: String
    let refreshToken: String
    let expiredAt: Date
}
