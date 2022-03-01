
import Foundation
import UIKit

extension UIView {
    
    static func name() -> String {
        return String(describing: self)
    }
    
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.map { $0.superview(of: type)! }
    }
    
    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func addToSelfWithPositions(view: UIView?, left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        guard let view = view else {
            return
        }
        self.addSubview(view)
        view.pinTop(top)
        view.pinLeft(left)
        view.pinRight(right)
        view.pinBottom(bottom)
    }
    
    func addToSelf(view: UIView?) {
        guard let view = view else {
            return
        }
        
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = view.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let rightConstraint = view.rightAnchor.constraint(equalTo: self.rightAnchor)
        let leftConstraint = view.leftAnchor.constraint(equalTo: self.leftAnchor)
        NSLayoutConstraint.activate([topConstraint,bottomConstraint, rightConstraint, leftConstraint])
    }
    
    func pinLeft(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
        leftAnchor.constraint(equalTo: superView.leftAnchor, constant: constant).isActive = true
    }
    
    func pinRight(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
        rightAnchor.constraint(equalTo: superView.rightAnchor, constant: constant).isActive = true
    }
    
    func pinTop(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
        topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
    }
    
    func pinBottom(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: constant).isActive = true
    }
}
