
import Foundation
import Alamofire

class ApiManager: NSObject {
    
    private func checkReachability() -> Error? {
        if let reachability = TLReachabilityHelper.shared.reachability {
            if !reachability.isReachable {
                let userInfo: [String : Any] = [NSLocalizedDescriptionKey : NSLocalizedString("kOfflineMessage", comment: "")]
                let err = NSError(domain: "", code: Constants.noInternetCode, userInfo: userInfo)
                return err
            }
        }
        return nil
    }
    
    func getRevisionDetails(requestConfig: TLRequestConfig, completionHandler: @escaping( _ response: [String: Any]? , _ error : Error?) -> Void) {
        
        if let reachabilityError = checkReachability() {
            completionHandler(nil, reachabilityError)
            return
        }
        
        TLNetworkManager.requestForConfig(requestConfig) { (response, error) in
            if response != nil {
                debugPrint(response as Any)
                if let json = response {
                } else {
                    completionHandler(nil,error)
                }
            }else {
                completionHandler(nil, error)
            }
        }
    }
    
}

