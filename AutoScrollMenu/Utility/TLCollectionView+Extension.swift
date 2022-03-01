
import Foundation
import UIKit

extension UICollectionView {
   
    func dequeueReusableCell<T: UICollectionViewCell>(_ className: T.Type, indexPath: IndexPath) -> T {
        let className = String.getStringOfClass(objectClass: className as AnyClass)
        return self.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as! T
    }
}
