import Foundation

struct Photos:Codable{
    var total: Int?
    var total_pages: Int?
    var results: [Photo]?
}

struct Photo:Codable{
    var id: String!
    var urls: Images?
    var likes: Int?
    var description: String? = nil
    var user: User?
}

struct Images:Codable {
    var small: String?
    var regular: String?
}

struct User:Codable {
    var username:  String?
    var name: String?
    var portfolio_url: String?
    var profile_image: ProfileImage?
}

struct ProfileImage:Codable {
    var medium: String?
}


