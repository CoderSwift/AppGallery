import Foundation

struct UserProfilePhotos:Codable{
    var id: String?
    var urls: PhotosUser?
    var likes: Int?
}

struct PhotosUser:Codable {
    var thumb: String?
    var regular: String?
}
