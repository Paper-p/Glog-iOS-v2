
import Foundation
import Moya

enum UserService{
    case userProfile(param: user)
}

extension UserService: TargetType{
    public var baseURL: URL{
        return URL(string: GlogAPI.baseURL)!
    }
    
    var path: String{
        switch self {
        
        }
    }
    
    var method: Moya.Method{
        switch self {
       
        }
    }
    
    var sampleData: Data{
        return "@@".data(using: .utf8)!
    }
    
    var task: Task{
        switch self {
        
    }
    
    var headers: [String : String]?{
        let tk = Keychain()
        switch self {
        
            return ["Authorization" : "Bearer \(tk.read(key: "accessToken")!)"]
        default:
            return["Content-Type" : "application/json"]
        }
    }
}
