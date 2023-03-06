
import Foundation

struct SignUpModel: Codable{
    let data: SignUpResponse
}

struct SignUpResponse: Codable{
    let accessToken: String
    let refreshToken: String
    let expiredAt: Date
}
