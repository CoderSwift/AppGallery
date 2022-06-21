import UIKit

extension UIView {
    func shodowView(corner:CGFloat) {
        self.clipsToBounds = false
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = Constants.shadowRadiusValue
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: Constants.zeroValue, height: Constants.zeroValue)
        self.layer.shadowOpacity = Constants.shadowOpacityValue
    }
    
    func setCorner(corner:CGFloat){
        self.layer.cornerRadius = corner
        self.clipsToBounds = true
    }
}

extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = Constants.blurValue
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
