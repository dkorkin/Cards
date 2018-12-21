
import UIKit


internal extension UICollectionView {

    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(_ : T.Type, kind: String) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T? where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(kind: String, indexPath: IndexPath) -> T? where T: Reusable {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
    
}
