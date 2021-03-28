import Foundation

struct UserProfile:Codable{
    var id: String?
    var name: String?
    var username: String?
    var bio: String? = nil
    var total_photos: Int?
    var profile_image: UserProfileImage?
    var followers_count: Int?
    var tags: Custom?
}

struct Custom:Codable {
    var custom: [TitleTag]?
}

struct TitleTag:Codable {
    var title: String?
}

struct UserProfileImage:Codable {
    var medium: String?
    var large: String?
}
