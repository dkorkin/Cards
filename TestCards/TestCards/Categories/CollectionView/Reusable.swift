import UIKit

internal protocol Reusable: class {
    
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

internal extension Reusable {
    
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: String(describing: self), bundle: nil) }
}

extension UICollectionReusableView: Reusable { }
