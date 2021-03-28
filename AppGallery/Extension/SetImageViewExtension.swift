import UIKit
import Kingfisher

extension UIImageView {
    func setImage(urlString:String){
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: URL(string: urlString),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
