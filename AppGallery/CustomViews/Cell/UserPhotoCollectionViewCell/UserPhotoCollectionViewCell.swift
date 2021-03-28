import UIKit

class UserPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var boxLikeView: UIView!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boxView.shodowView(corner:  Constants.cornerValueSmall)
        photoImageView.setCorner(corner:  Constants.cornerValueSmall)
        boxLikeView.shodowView(corner:  Constants.cornerValueSmall)
        boxLikeView.setCorner(corner:  Constants.cornerValueSmall)
    }
    
     func configurtion(userProfilePhotos: UserProfilePhotos) {
        guard let image = userProfilePhotos.urls?.thumb else {return}
        guard let likePhoto = userProfilePhotos.likes else {return}
        self.photoImageView.setImage(urlString: image)
        self.likeLabel.text = "Like: \(likePhoto)"
    }
    
}
