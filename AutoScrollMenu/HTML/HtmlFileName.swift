

import Foundation

public enum HtmlFileName {
    case cardView
    case revisionList
    
    public var fileName: String {
        switch self {
        case .cardView:
            return "Revision"
            
        case .revisionList:
            return "RevisionList"
        }
    }
    
    public var path: URL? {
        let fileName = self.fileName
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "html") else {
            print("Can't find file \(fileName)")
            return nil
        }
        return URL(fileURLWithPath: path)
    }
}
