
import UIKit
import Moya

final class Interceptor: RequestInterceptor{
    
    let tk = Keychain()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(GlogAPI.baseURL) == true,
              let accessToken = tk.read(key: "acceessToken") else{
            completion(.success(urlRequest))
        }
    }
}
