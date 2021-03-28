//
//  UserViewController.swift
//  AppGallery
//
//  Created by coder on 9.03.21.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var mainBackgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var countPhotosLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var titleAboutLabel: UILabel!
    @IBOutlet weak var interestsCollectionView: UICollectionView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    
    var userProfileName = String()
    var userName = String()
    var userProfile = UserProfile()
    var userPhotos:[UserProfilePhotos] = []
    var countTags = 0
    var tagInterest:[TitleTag] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyleElement()
        registerCell()
        NetworkManage.feachUser(queryUser: userProfileName) { (userProfile) in
            self.userProfile = userProfile
            guard let countTag = userProfile.tags?.custom?.count else {return}
            DispatchQueue.main.async { [self] in
                self.countTags = countTag
                self.tagInterest = (userProfile.tags?.custom)!
                setConfiguration(userProfile: userProfile)
                interestsCollectionView.reloadData()
            }
        }
        setfeacthUser()
    }
    
    private func setfeacthUser(){
        self.feacthUser(with: userProfileName)
    }
    
    private func feacthUser(with queryString: String) {
        NetworkManage.feachUserPhotos(queryUser: queryString) { [self] (userPhotos) in
            self.userPhotos = userPhotos
            DispatchQueue.main.async {
                photosCollectionView.reloadData()
            }
        }
    }
    
    private func  registerCell() {
        interestsCollectionView.register(cellType: InterestsCollectionViewCell.self)
        photosCollectionView.register(cellType: UserPhotoCollectionViewCell.self)
    }
    
    private func setConfiguration(userProfile: UserProfile){
        self.titleAboutLabel.text = Constants.aboutTitle
        guard let nameUser = userProfile.name  else {return}
        guard let imageUser = userProfile.profile_image?.large  else {return}
        guard let countPhotoUser = userProfile.total_photos  else {return}
        nameUserLabel.text = nameUser
        countPhotosLabel.text = "Photos \(countPhotoUser)"
        if userProfile.bio == nil {
            titleAboutLabel.isHidden = true
            aboutLabel.isHidden = true
        } else {
            self.aboutLabel.text = userProfile.bio
        }
        userImageView.setImage(urlString: imageUser)
    }
    
    private func configureStyleElement(){
        userImageView.setCorner(corner:self.userImageView.frame.width/CGFloat(Constants.userRadius))
        backButton.setCorner(corner: backButton.frame.height/CGFloat(Constants.userRadius))
    }

    @IBAction func backActionButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension UserViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.interestsCollectionView {
            return countTags
        } else {
            return userPhotos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.interestsCollectionView {
            let cell = interestsCollectionView.dequeueReusableCell(with: InterestsCollectionViewCell.self, for: indexPath)
            cell.configuration(userProfile: tagInterest[indexPath.row])
            return cell
        }
        else {
            let cell = photosCollectionView.dequeueReusableCell(with: UserPhotoCollectionViewCell.self, for: indexPath)
            cell.configurtion(userProfilePhotos: userPhotos[indexPath.row])
            return cell
            
        }
    }
}

extension UserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.interestsCollectionView{
            return UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.interestsCollectionView{
            return CGSize(width: 100, height: 25)
        } else {
           
            let sizeCell = collectionView.frame.height 
            return CGSize(width: sizeCell, height: sizeCell)
        }
    }
}
