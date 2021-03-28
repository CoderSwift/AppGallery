import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet private weak var photosUserCollectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionPhotoLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var boxLikeView: UIView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var constraintsTopPanel: NSLayoutConstraint!
    @IBOutlet weak var panelTopStackView: UIStackView!
    @IBOutlet weak var constraintsTopDescriptionStackView: NSLayoutConstraint!
    
    var photoBig = Photo()
    var userName = String()
    var userPhotos:[UserProfilePhotos] = []
    var heightStatusBar = UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureStyleElement()
        setfeacthUser()
        registrationRecognizer()
        setUserPhotos(with: photoBig)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.constraintsTopPanel.constant = heightStatusBar + 10
    }
    
    @IBAction func backActionButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapUserProfile(_ gestureRecognizer: UITapGestureRecognizer){
        let vcUser = storyboard?.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        vcUser.userProfileName = userName
        self.navigationController?.pushViewController(vcUser, animated: true)
    }
    
    private func registrationRecognizer(){
        let recognizerUserImage = UITapGestureRecognizer()
        recognizerUserImage.addTarget(self, action: #selector(tapUserProfile(_:)))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(recognizerUserImage)
    }
    
    private func  registerCell() {
        photosUserCollectionView.register(cellType: UserPhotoCollectionViewCell.self)
    }
    
    private func configureStyleElement(){
        backgroundImageView.applyBlurEffect()
        mainView.shodowView(corner: Constants.cornerValueSmall)
        backButton.setCorner(corner: backButton.frame.height/CGFloat(Constants.userRadius))
        boxLikeView.setCorner(corner: boxLikeView.frame.height/CGFloat(Constants.userRadius))
        mainImageView.setCorner(corner: Constants.cornerValueSmall)
        userView.shodowView(corner:self.userImageView.frame.width/CGFloat(Constants.userRadius))
        userImageView.setCorner(corner:self.userImageView.frame.width/CGFloat(Constants.userRadius))
    }
    
    private func setfeacthUser(){
        guard let userName = photoBig.user?.username else {return}
        self.userName = userName
        self.feacthUser(with: userName)
    }
    
    private func feacthUser(with queryString: String) {
        NetworkManage.feachUserPhotos(queryUser: queryString) { [self] (userPhotos) in
            self.userPhotos = userPhotos
            DispatchQueue.main.async {
                photosUserCollectionView.reloadData()
            }
        }
    }
    
    private func setUserPhotos(with userPhoto: Photo) {
        guard let userImages = photoBig.user?.profile_image?.medium else {return}
        guard let image = photoBig.urls?.regular else {return}
        guard  let userName = photoBig.user?.name else {return}
        guard let photoLike = photoBig.likes else {return}
        self.descriptionTitleLabel.text = Constants.descriptionTitle
        self.userImageView.setImage(urlString: userImages)
        self.mainImageView.setImage(urlString: image)
        self.backgroundImageView.setImage(urlString: image)
        self.userLabel.text = userName
        if photoBig.description == nil {
            descriptionTitleLabel.isHidden = true
            descriptionPhotoLabel.isHidden = true
            self.constraintsTopDescriptionStackView.constant = 0
        } else {
            self.descriptionPhotoLabel.text = photoBig.description
        }
        self.likeLabel.text = "Like: \(photoLike)"
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: UserPhotoCollectionViewCell.self, for: indexPath)
        cell.configurtion(userProfilePhotos: userPhotos[indexPath.row])
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.backgroundImageView.setImage(urlString: (userPhotos[indexPath.row].urls?.regular)!)
        self.mainImageView.setImage(urlString: (userPhotos[indexPath.row].urls?.regular)!)
        self.likeLabel.text = "Like: \(userPhotos[indexPath.row].likes!)"
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCell = collectionView.frame.height - 30
        return CGSize(width: sizeCell, height: sizeCell)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 5, bottom: 0, right: 5)
    }
}


