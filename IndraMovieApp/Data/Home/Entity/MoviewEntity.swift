//
//  MoviewEntity.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation
import RealmSwift

struct Movies: Codable {
    let listOfMovies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case listOfMovies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let popularity: Double
    let movieID: Int
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let sinopsis: String
    let releaseDate: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case popularity
        case movieID = "id"
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case sinopsis = "overview"
        case releaseDate = "release_date"
        case image = "poster_path"
    }
}

class MovieBD: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var movieID: Int = 0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var sinopsis: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var image: String = ""
    
    convenience init(movieID: Int, title: String,
                     popularity: Double,
                     voteCount: Int,
                     originalTitle: String,
                     voteAverage: Double,
                     sinopsis: String,
                     releaseDate: String,
                     image: String) {
        self.init()
        
        self.movieID = movieID
        self.title = title
        self.popularity = popularity
        self.voteCount = voteCount
        self.originalTitle = originalTitle
        self.voteAverage = voteAverage
        self.sinopsis = sinopsis
        self.releaseDate = releaseDate
        self.image = image
    }
    
    override static func primaryKey() -> String? {
        return "movieID"
    }
}
