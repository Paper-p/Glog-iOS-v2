
import Foundation

struct RefreshModel: Codable{
    let data: RefreshResponse
}

struct RefreshResponse: Codable{
    let accessToken: String
    let refreshToken: String
    let expiredAt: String
}
