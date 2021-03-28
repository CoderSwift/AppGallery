import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var boxSearchBarView: UIView!
    
    var photo:[Photo] = []
    var countPage:Int = 0
    var loadingStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setFeacthPhoto(page:Constants.indexOfPageRequest, queryString: "all")
        searchBarTextField.setCorner(corner: Constants.cornerValue)
        boxSearchBarView.setCorner(corner: Constants.cornerValue)
        boxSearchBarView.shodowView(corner: Constants.cornerValue)
        searchBarTextField.setLeftPaddingPoints(55)
        searchBarTextField.setImage(UIImage(named: "icon-search")!)
        searchBarTextField.delegate = self
    }
    
    private func setFeacthPhoto(page: Int, queryString: String) {
        NetworkManage.feachPhotos(page: page, query: queryString) { [self] (photoList) in
            guard let photoListsResult = photoList.results else {return}
            guard let totalPage = photoList.total_pages else {return}
            self.countPage = totalPage
            self.photo.append(contentsOf: photoListsResult)
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                galleryCollectionView.reloadData()
                Constants.indexOfPageRequest += 1
                loadingStatus = false
            }
            )}
    }
    
    private func  registerCell() {
        galleryCollectionView.register(cellType: PhotoCollectionViewCell.self)
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PhotoCollectionViewCell.self, for: indexPath)
        cell.configurtion(photoModel: photo[indexPath.row])
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width) / 2
        let height = width * Constants.procentViewSizeGridValue
        return CGSize(width: width, height: height)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vcPhoto = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        vcPhoto.photoBig = photo[indexPath.row]
        self.navigationController?.pushViewController(vcPhoto, animated: true)
    }
}

extension MainViewController: UIScrollViewDelegate {
    func loadData(){
        if !loadingStatus{
            loadingStatus = true
            if searchBarTextField.text == "" {
                setFeacthPhoto(page: Constants.indexOfPageRequest, queryString:  "all")
            } else {
                setFeacthPhoto(page: Constants.indexOfPageRequest, queryString:  searchBarTextField.text!)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            if countPage+1 == Constants.indexOfPageRequest {
                loadingStatus = true
            } else {
                loadData()
            }
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (searchBarTextField.text?.count)! != 0 {
            self.galleryCollectionView.reloadData()
            Constants.indexOfPageRequest = 1
            self.setFeacthPhoto(page: Constants.indexOfPageRequest, queryString: searchBarTextField.text!)
        }
        self.photo = []
        galleryCollectionView.reloadData()
        self.view.endEditing(true)
        return false
    }
}


