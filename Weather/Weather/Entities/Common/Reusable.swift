import UIKit

protocol ReusableCell: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}

extension UITableView {

    func register<T: UITableViewCell>(withNibFor _: T.Type) where T: ReusableCell {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_: T.Type) -> T where T: ReusableCell {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(withNibFor _: T.Type) where T: ReusableCell {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: Bundle(for: T.self))
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: ReusableCell {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
