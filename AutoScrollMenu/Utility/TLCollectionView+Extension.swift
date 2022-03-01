
import Foundation
import UIKit

extension UICollectionView {
   
    func registerCell<T: UICollectionViewCell>(_ cellName: T.Type) {
        self.register(UINib(nibName: cellName.name(), bundle: nil), forCellWithReuseIdentifier: cellName.name())
    }
    
    func registerNib(_ className: AnyClass) {
        let classNameString = String.getStringOfClass(objectClass: className)
        register(UINib.init(nibName: classNameString, bundle: .main), forCellWithReuseIdentifier: classNameString)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ className: T.Type, indexPath: IndexPath) -> T {
        let className = String.getStringOfClass(objectClass: className as AnyClass)
        return self.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as! T
    }
}
