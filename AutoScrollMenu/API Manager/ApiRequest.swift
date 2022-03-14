
import Foundation

enum ApiRequest {
    case getRevisionDetails(chapterID: String,
                              subjectID: String)
    
    private func getHeaderParams() -> [String: String] {
        switch self {
        case .getRevisionDetails:
            return self.getDefaultRequestHeaderWithData(nil)
        }
    }
    
    func getDefaultRequestHeaderWithData(_ headerDict: [String:String]?)-> [String:String] {
        
        var values = ["Content-Type": "application/json"]
        values["Accept"] = "application/json"
        values ["X-TNL-APPVERSION"] = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        values ["X-TNL-DEVICEOS"] = "ios"
        values ["Accept-Encoding"] = "gzip"
        values["X-TNL-FEATURES"] = ""
        values["X-TNL-APPID"] = "1"
        values["X-TNL-TOKEN"] = "E1YLt-XunhkPETQrFKKzY294"
        values["X-TNL-USER-ID"] = "2667535"
        
        return values
    }
    
    private func getURL() -> String {
        var url = Constants.APIUrl.baseUrl
        switch self {
        case .getRevisionDetails(let chapterID, let subjectID):
            url += "elearn/api/v4/revisions/contents/?chapter_id=\(chapterID)&subject_id=\(subjectID)"
        }
        return url
    }
    
    private func getBodyParams() -> [String: AnyObject]? {
        switch self {
        case .getRevisionDetails(chapterID: _, subjectID: _):
            return nil
        }
    }
    
    private func requestType() -> TLRequestType {
        switch self {
        case .getRevisionDetails:
            return TLRequestType.get
        default:
            return TLRequestType.post
        }
    }
    
    func getApiConfig() -> TLRequestConfig {
        return TLRequestConfig.init(completeUrl: self.getURL(), requestHeaders: self.getHeaderParams(), requestType: self.requestType(), params: self.getBodyParams())
    }
}
