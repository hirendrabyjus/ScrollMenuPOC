
import Foundation
import UIKit
import SwiftUI

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

extension UIHostingController {
    
    func activateConstraints(containerView: UIView) {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
