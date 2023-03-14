
import UIKit
import Moya
import Alamofire

final class Interceptor: RequestInterceptor{
    
    let tk = Keychain()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(GlogAPI.baseURL) == true,
              let accessToken = tk.read(key: "acceessToken") else{
            completion(.success(urlRequest))
            return
        }
        var urlRequest = urlRequest
        urlRequest.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        let url = GlogAPI.baseURL
        let headers: HTTPHeaders = ["RefreshToken" : tk.read(key: "refreshToken")!]
        
        AF.request(url, method: .patch, encoding: JSONEncoding.default, headers: headers).responseData { [weak self] response in
            switch response.result{
            case .success(let tokenData):
                self?.tk.deleteAll()
                
                if let refreshToken = (try? JSONSerialization.jsonObject(with: tokenData, options: []) as? [String: Any])? ["refreshToken"] as? String {
                    self?.tk.create("refreshToken", token: refreshToken)
                }
                
                if let accessToken = (try? JSONSerialization.jsonObject(with: tokenData, options: []) as? [String: Any])? ["accessToken"] as? String {
                    self?.tk.create("accessToken", token: accessToken)
                }
                completion(.retry)
            case .failure(let error):
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
