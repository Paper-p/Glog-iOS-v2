
import Security
import UIKit

class Keychain{
    func create(_ key: String, token: String){
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false)!
        ]
        SecItemDelete(keyChainQuery)
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "토큰 저장 실패")
    }
    
    func read(key: String) -> String?{
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        if (status == errSecSuccess){
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else{
            print("failed to loading, status code = \(status)")
            return nil
        }
    }
    
}
