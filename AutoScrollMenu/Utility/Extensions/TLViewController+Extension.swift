
import Foundation
import UIKit

extension UIViewController {
    
    func addChildVC(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }
}
