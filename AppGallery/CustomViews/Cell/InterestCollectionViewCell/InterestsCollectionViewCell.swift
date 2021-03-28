import UIKit

class InterestsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var interestsView: UIView!
    @IBOutlet weak var titleInterestsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        interestsView.setCorner(corner: 5)
        interestsView.shodowView(corner: 5)
        
    }
    
    func configuration(userProfile:TitleTag){
        self.titleInterestsLabel.text = userProfile.title
    }

}
