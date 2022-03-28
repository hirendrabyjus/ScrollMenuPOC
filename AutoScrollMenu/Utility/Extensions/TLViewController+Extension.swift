
import Foundation
import UIKit
import SwiftUI

extension UIViewController {
    
    func addChildVC(_ child: UIViewController, _ containerView: UIView? = nil) {
        addChild(child)
        if containerView == nil {
            view.addSubview(child.view)
        } else {
            containerView?.addSubview(child.view)
        }
        child.didMove(toParent: self)
    }
    
    func activateContainerViewConstraints(_ containerView: UIView) {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            self.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }
}
