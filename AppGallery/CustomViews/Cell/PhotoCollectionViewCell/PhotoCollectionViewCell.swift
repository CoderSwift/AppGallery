import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var boxImageView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var boxUserImageView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boxImageView.shodowView(corner:  Constants.cornerValueSmall)
        photoImageView.setCorner(corner: Constants.cornerValueSmall)
        boxUserImageView.setCorner(corner: self.boxUserImageView.frame.width/2)
        userImageView.setCorner(corner: self.boxUserImageView.frame.width/2)
        setGradientLayer()
    }
   
    fileprivate func setGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1]
        self.photoImageView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func configurtion(photoModel: Photo) {
        guard let image = photoModel.urls?.small else {return}
        guard let imageUser = photoModel.user?.profile_image?.medium else {return}
        guard let name = photoModel.user?.username else {return}
        self.photoImageView.setImage(urlString: image)
        self.userImageView.setImage(urlString: imageUser)
        self.userNameLabel.text = name
    }
    

}
