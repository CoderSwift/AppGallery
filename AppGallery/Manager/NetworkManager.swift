import Foundation

class NetworkManage {
    static func feachPhotos(page: Int, query: String, complation: @escaping (_ photos: Photos)->()) {
        let urlString = "https://api.unsplash.com/search/photos?page=\(page)&per_page=10&query=\(query)&client_id=Z05Qch5SXCuUIt3FwwyhlvfInMNvIu2bdDRY7oprPPM"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response , error) in
            guard let data = data, error == nil else {return}
            do {
                let json = try JSONDecoder().decode(Photos.self, from: data)
                complation(json)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    static func feachUserPhotos(queryUser: String, complation: @escaping (_ photos: [UserProfilePhotos])->()) {
        let urlString = "https://api.unsplash.com/users/\(queryUser)/photos?per_page=10&page=1&client_id=Z05Qch5SXCuUIt3FwwyhlvfInMNvIu2bdDRY7oprPPM"
        guard let url = URL(string: urlString) else {return}
       
        URLSession.shared.dataTask(with: url) { (data, response , error) in
            guard let data = data, error == nil else {return}
            do {
                let json = try JSONDecoder().decode([UserProfilePhotos].self, from: data)
                complation(json)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    static func feachUser(queryUser: String, complation: @escaping (_ photos: UserProfile)->()) {
        let urlString = "https://api.unsplash.com/users/\(queryUser)?client_id=Z05Qch5SXCuUIt3FwwyhlvfInMNvIu2bdDRY7oprPPM"
        guard let url = URL(string: urlString) else {return}
       
        URLSession.shared.dataTask(with: url) { (data, response , error) in
            guard let data = data, error == nil else {return}
            do {
                let json = try JSONDecoder().decode(UserProfile.self, from: data)
                complation(json)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
