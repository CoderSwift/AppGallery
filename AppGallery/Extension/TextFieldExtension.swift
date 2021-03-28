import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: CGFloat(Constants.zeroValue), y: CGFloat(Constants.zeroValue), width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: CGFloat(Constants.zeroValue), y: CGFloat(Constants.zeroValue), width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setImage(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: Constants.iconViewMarginValue, y: Constants.iconViewMarginValue, width: Constants.iconViewSizeValue, height: Constants.iconViewSizeValue)) // set
            iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: Constants.zeroValue, y: Constants.zeroValue, width: Constants.iconViewContainerSizeValue, height: Constants.iconViewContainerSizeValue))
            iconContainerView.addSubview(iconView)
            leftView = iconContainerView
            leftViewMode = .always
    }
}

