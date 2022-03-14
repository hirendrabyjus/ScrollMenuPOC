
import Foundation
import UIKit

enum Storyboard: String {
    
    case main = "Main"
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    func instantiateVC<T: UIViewController>(_ objectClass: T.Type) -> T {
        return instance.instantiateViewController(withIdentifier: String.getStringOfClass(objectClass: objectClass)) as! T
    }
}
