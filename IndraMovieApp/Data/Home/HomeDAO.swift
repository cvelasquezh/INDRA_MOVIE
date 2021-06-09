//
//  HomeDAO.swift
//  IndraMovieApp
//
//  Created by MDP-DESARROLLADOR on 6/8/21.
//

import Foundation

protocol HomeDAOProtocol {
    func saveMovie(item: MovieBD)
    func saveMovies(items: [MovieBD])
    func deleteMovie(item: MovieBD)
    func deleteMovies(movieID: String)
    
    func getMovies(movieID: String) -> [MovieBD]
    func getAllMovies() -> [Movie]
    func deleteAllMovies()
}

class HomeDAO: RealmDataBase<MovieBD>, HomeDAOProtocol {
    func deleteAllMovies() {
        let notificationsAll = self.getAll()
        
        if !notificationsAll.isEmpty {
            self.delete(items: notificationsAll)
        }
    }
    
    func saveMovie(item: MovieBD) {
        self.save(item: item)

    }
    
    func saveMovies(items: [MovieBD]) {
        self.save(items: items)
    }
    
    func deleteMovie(item: MovieBD) {
        let filterPredicate = "movieID = '\(item.movieID)'"
        let movieDelete = self.getAll().filter(filterPredicate)
        
        if !movieDelete.isEmpty {
            self.delete(items: movieDelete)
        }
    }
    
    func deleteMovies(movieID: String) {
        let notificationsAll = self.getAll().filter("movieID = '\(movieID)'")
        
        if !notificationsAll.isEmpty {
            self.delete(items: notificationsAll)
        }
    }
    
    func getMovies(movieID: String) -> [MovieBD] {
        let favoritesAll = self.getAll().filter("movieID = '\(movieID)'")
        var favoritesAllList: [MovieBD] = []
        
        favoritesAllList.append(contentsOf: favoritesAll)
        
        return favoritesAllList
    }
    
    func getAllMovies() -> [Movie] {
        let all = self.getAll().map { (movieBD) -> Movie in
            Movie(title: movieBD.title ,
                  popularity: movieBD.popularity,
                  movieID: movieBD.movieID, voteCount: 0,
                  originalTitle: movieBD.originalTitle,
                  voteAverage: movieBD.voteAverage,
                  sinopsis: movieBD.sinopsis,
                  releaseDate: movieBD.releaseDate,
                  image: movieBD.image)
        }
        var allMovies: [Movie] = []
        allMovies.append(contentsOf: all)
        return allMovies
    }
}

