import  UIKit

public extension UICollectionViewCell {
    var collectionView:UICollectionView?{
        return superview as? UICollectionView
    }

    var indexPath:IndexPath?{
        return collectionView?.indexPath(for: self)
    }
}
